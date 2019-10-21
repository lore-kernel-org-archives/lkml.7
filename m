Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88FADCA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 13:41:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F1EC20679
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 13:41:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b6F9VmDh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729786AbfJUNlx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 09:41:53 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:46079 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729769AbfJUNlt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 09:41:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571665308;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/hrlMRSNUV7GfQJokj3U631Cnr3v4gmMYYBdE3Q72JM=;
        b=b6F9VmDh7k0EHGtl3otLaaCiVAL25y7yTiKG592UesEg4jikUgokr1HOfQJ131f0ZsqAoo
        QkQOEnPfLbi0kcl+OtLfMPuPZdWnTkA3Xp+MKJ3//nIHFposzEDyFrHwZFTmTENGKDkRpT
        hacx0K2EAf2ei0kKHd52mOLiWR6KJKk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-47-5gj69c9WNK-7mJg0Vgjbpg-1; Mon, 21 Oct 2019 09:41:44 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E92BE80183E;
        Mon, 21 Oct 2019 13:41:42 +0000 (UTC)
Received: from krava (unknown [10.43.17.61])
        by smtp.corp.redhat.com (Postfix) with SMTP id 73A226012D;
        Mon, 21 Oct 2019 13:41:38 +0000 (UTC)
Date:   Mon, 21 Oct 2019 15:41:37 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Jiwei Sun <jiwei.sun@windriver.com>
Cc:     acme@redhat.com, arnaldo.melo@gmail.com,
        linux-kernel@vger.kernel.org, alexander.shishkin@linux.intel.com,
        mpetlan@redhat.com, namhyung@kernel.org, a.p.zijlstra@chello.nl,
        adrian.hunter@intel.com, Richard.Danter@windriver.com
Subject: Re: [PATCH v4] perf record: Add support for limit perf output file
 size
Message-ID: <20191021134137.GA8264@krava>
References: <20190925070637.13164-1-jiwei.sun@windriver.com>
MIME-Version: 1.0
In-Reply-To: <20190925070637.13164-1-jiwei.sun@windriver.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: 5gj69c9WNK-7mJg0Vgjbpg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 25, 2019 at 03:06:37PM +0800, Jiwei Sun wrote:

SNIP

>  SEE ALSO
>  --------
>  linkperf:perf-stat[1], linkperf:perf-list[1]
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index 48600c90cc7e..30904d2a3407 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -91,6 +91,7 @@ struct record {
>  =09struct switch_output=09switch_output;
>  =09unsigned long long=09samples;
>  =09cpu_set_t=09=09affinity_mask;
> +=09unsigned long=09=09output_max_size;=09/* =3D 0: unlimited */
>  };
> =20
>  static volatile int auxtrace_record__snapshot_started;
> @@ -120,6 +121,12 @@ static bool switch_output_time(struct record *rec)
>  =09       trigger_is_ready(&switch_output_trigger);
>  }
> =20
> +static bool record__output_max_size_exceeded(struct record *rec)
> +{
> +=09return rec->output_max_size &&
> +=09       (rec->bytes_written >=3D rec->output_max_size);
> +}
> +
>  static int record__write(struct record *rec, struct mmap *map __maybe_un=
used,
>  =09=09=09 void *bf, size_t size)
>  {
> @@ -132,6 +139,12 @@ static int record__write(struct record *rec, struct =
mmap *map __maybe_unused,
> =20
>  =09rec->bytes_written +=3D size;
> =20
> +=09if (record__output_max_size_exceeded(rec)) {
> +=09=09WARN_ONCE(1, "WARNING: The perf data has already reached "
> +=09=09=09     "the limit, stop recording!\n");

I think the message whouldn't be a warning, the user asked for
that, maybe something more like:

  [ perf record: perf size limit reached (XXMB), stopping session ]

> +=09=09raise(SIGTERM);

could we just set 'done =3D 1' what's the benefit in killing perf?

thanks,
jirka

