Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C74ACA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 09:27:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7021820830
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 09:27:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BUZTqvnC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732689AbfJ2J14 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 05:27:56 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53874 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726025AbfJ2J1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 05:27:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572341274;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PGQ5a20be/ydX+TegMd0oI7neivjU7ixN4Nk+m9ezbU=;
        b=BUZTqvnCFb6VcFZlTuDbtwQfjZ7pTcEmGfNCWCiTdjD092ru5v3Hgk7uLQkJLI7amp/dN1
        Otu3BxOfZGRIcrsMrfj/JZbwca531K3CEVxd6PdsouxSnC9iByM/voywsnLUzjfzxhRJua
        MufVzJQV2ImU+BCSxBZrVs2sLv+vwJA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-432-ZmhAmyodP0ScFTgmYkC1ww-1; Tue, 29 Oct 2019 05:27:51 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0E894801E64;
        Tue, 29 Oct 2019 09:27:50 +0000 (UTC)
Received: from krava (unknown [10.43.17.61])
        by smtp.corp.redhat.com (Postfix) with SMTP id 1E6455D6C3;
        Tue, 29 Oct 2019 09:27:47 +0000 (UTC)
Date:   Tue, 29 Oct 2019 10:27:47 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v4 5/7] perf report: Sort by sampled cycles percent per
 block for stdio
Message-ID: <20191029092747.GH28772@krava>
References: <20191028013330.18319-1-yao.jin@linux.intel.com>
 <20191028013330.18319-6-yao.jin@linux.intel.com>
MIME-Version: 1.0
In-Reply-To: <20191028013330.18319-6-yao.jin@linux.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: ZmhAmyodP0ScFTgmYkC1ww-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 28, 2019 at 09:33:28AM +0800, Jin Yao wrote:

SNIP

> diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
> index 0e27d6830011..7cf137b0451b 100644
> --- a/tools/perf/util/hist.c
> +++ b/tools/perf/util/hist.c
> @@ -758,6 +758,10 @@ struct hist_entry *hists__add_entry_block(struct his=
ts *hists,
>  =09struct hist_entry entry =3D {
>  =09=09.block_info =3D block_info,
>  =09=09.hists =3D hists,
> +=09=09.ms =3D {
> +=09=09=09.map =3D al->map,
> +=09=09=09.sym =3D al->sym,
> +=09=09},

this looks like separated fix, if thats the case
please explain the change and move it to separate patch

thanks,
jirka

