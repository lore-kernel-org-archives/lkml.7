Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C6FBCA9EB6
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 11:36:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 694AC2084B
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 11:36:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VDqQQjvi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405054AbfJWLgu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 07:36:50 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:31639 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2390721AbfJWLgt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 07:36:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571830608;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cu1QBUOIg5c57lx20wcNvleGK6xUN1N2MwRE99CMu+8=;
        b=VDqQQjviw4EHEcfbCzfjyrtfT6xm8I8i0QK+kECrXGyINKpB8EqJGrO4GAv1886Nh4fntW
        5d4jwER8xo/3r5XYi+6uYtfurBaZ3F5Ike9got1ng7wFHeawXWWbFL+yQ5MIEKvOvuWaSG
        M7WrOFxKskrY04+i3a0b+vi28Vju5Ys=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-202-sC3F95xNMDCf0VHU5NoHNQ-1; Wed, 23 Oct 2019 07:36:47 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 78F22107AD31;
        Wed, 23 Oct 2019 11:36:45 +0000 (UTC)
Received: from krava (unknown [10.43.17.61])
        by smtp.corp.redhat.com (Postfix) with SMTP id 8658A194BB;
        Wed, 23 Oct 2019 11:36:43 +0000 (UTC)
Date:   Wed, 23 Oct 2019 13:36:42 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v3 3/5] perf report: Sort by sampled cycles percent per
 block for stdio
Message-ID: <20191023113642.GN22919@krava>
References: <20191022080710.6491-1-yao.jin@linux.intel.com>
 <20191022080710.6491-4-yao.jin@linux.intel.com>
MIME-Version: 1.0
In-Reply-To: <20191022080710.6491-4-yao.jin@linux.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: sC3F95xNMDCf0VHU5NoHNQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 22, 2019 at 04:07:08PM +0800, Jin Yao wrote:

SNIP

> diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
> index 43d1d410854a..eb286700a8a9 100644
> --- a/tools/perf/util/sort.c
> +++ b/tools/perf/util/sort.c
> @@ -492,6 +492,10 @@ struct sort_entry sort_sym_ipc_null =3D {
>  =09.se_width_idx=09=3D HISTC_SYMBOL_IPC,
>  };
> =20
> +struct sort_entry sort_block_cycles =3D {
> +=09.se_cmp=09=09=3D sort__sym_cmp,
> +};

so this is here only for you to be able to write '-s total_cycles'
and has no other functonality right?

I think we'd be better with report boolean option instad, like
'perf report --total-cycles', because your code does the column
display by itself.. and we could get rid of this -s confusion

jirka

