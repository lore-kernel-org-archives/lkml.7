Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15CEACA9EC0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 15:45:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC942208C0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 15:45:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J9BNpIhB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731505AbfJ1PpN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 11:45:13 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:34213 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726387AbfJ1PpN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 11:45:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572277512;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sKoKwRNKJCybuQSknjd6nzlV+UiK4cb/9xjmazB7cic=;
        b=J9BNpIhBcDigYYgdRtWKrwZknzNcvd9ya5HdEX3FFBJLQ+RTAWGSQUbHXVQww1rCq4wEcl
        Lt833WT+mQT9Da80b9qRp/dG94njr4ZlsPeFa4VdsWNSmykKyQyJc8kYQyOGUuostwwTp3
        BqMyHv1IJtqomOfmzlJr33g3yXnpjS8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-39-tRFp7WB4OD-hXN-iKLLgMg-1; Mon, 28 Oct 2019 11:45:08 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3A7A91005509;
        Mon, 28 Oct 2019 15:45:07 +0000 (UTC)
Received: from krava (unknown [10.43.17.61])
        by smtp.corp.redhat.com (Postfix) with SMTP id DCE012635E;
        Mon, 28 Oct 2019 15:45:04 +0000 (UTC)
Date:   Mon, 28 Oct 2019 16:45:03 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 3/6] perf dso: Add dso__data_write_cache_addr()
Message-ID: <20191028154503.GB15449@krava>
References: <20191025130000.13032-1-adrian.hunter@intel.com>
 <20191025130000.13032-4-adrian.hunter@intel.com>
MIME-Version: 1.0
In-Reply-To: <20191025130000.13032-4-adrian.hunter@intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: tRFp7WB4OD-hXN-iKLLgMg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 25, 2019 at 03:59:57PM +0300, Adrian Hunter wrote:
SNIP

> =20
> -static ssize_t data_read_offset(struct dso *dso, struct machine *machine=
,
> -=09=09=09=09u64 offset, u8 *data, ssize_t size)
> +static ssize_t data_read_write_offset(struct dso *dso, struct machine *m=
achine,
> +=09=09=09=09      u64 offset, u8 *data, ssize_t size,
> +=09=09=09=09      bool out)
>  {
>  =09if (dso__data_file_size(dso, machine))
>  =09=09return -1;
> @@ -1034,7 +1037,7 @@ static ssize_t data_read_offset(struct dso *dso, st=
ruct machine *machine,
>  =09if (offset + size < offset)
>  =09=09return -1;
> =20
> -=09return cached_read(dso, machine, offset, data, size);
> +=09return cached_io(dso, machine, offset, data, size, out);

you renamed the function as _read_write_ so the bool choosing
the opration should be named either read or write.. I had to
go all the way down to find out what 'out' means ;-)

jirka

