Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E17FFC432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 20:09:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A979B2240E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 20:09:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H/L9weeX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727368AbfKSUJh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 15:09:37 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:48644 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726792AbfKSUJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 15:09:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574194176;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2W3nJWCtKErj/mBVCdNcn4Yhy0haPmI1GhQToMEpIos=;
        b=H/L9weeXrwFw86JxLfr0SF0rmLp9wJsBgtB/JjmlF8iH7InI3zfERy48cZAq+yKWFDrbpX
        zbodNAAqiiYHf0hh3gh3l0rKdw7isP6bcin6vsKSed42LD/TUTe0IUzDHX3fHQh11EFoh5
        D/S55wRTpenWCGiUVwwST4LVawIEuqw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-270-P71Zz6-MOES3KDICBMYhQA-1; Tue, 19 Nov 2019 15:09:32 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 44A5F8024CB;
        Tue, 19 Nov 2019 20:09:31 +0000 (UTC)
Received: from krava (ovpn-204-89.brq.redhat.com [10.40.204.89])
        by smtp.corp.redhat.com (Postfix) with SMTP id 3CF72D1E3;
        Tue, 19 Nov 2019 20:09:28 +0000 (UTC)
Date:   Tue, 19 Nov 2019 21:09:27 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v2 1/2] perf util: Move block tui function to ui browsers
Message-ID: <20191119200927.GB7364@krava>
References: <20191118140849.20714-1-yao.jin@linux.intel.com>
MIME-Version: 1.0
In-Reply-To: <20191118140849.20714-1-yao.jin@linux.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: P71Zz6-MOES3KDICBMYhQA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 18, 2019 at 10:08:48PM +0800, Jin Yao wrote:
> It would be nice if we could jump to the assembler/source view
> (like the normal perf report) from total cycles view.
>=20
> This patch moves the block_hists_tui_browse from block-info.c
> to ui/browsers/hists.c in order to reuse some browser codes
> (i.e do_annotate) for implementing new annotation view.
>=20
>  v2:
>  ---
>  Fix the 'make NO_SLANG=3D1' error. (Change 'int block_hists_tui_browse()=
'
>  to 'static inline int block_hists_tui_browse()')
>=20
> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>

for both patches

Acked-by:  Olsa <jolsa@redhat.com>

thanks,
jirka

