Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAA79C76190
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 15:52:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 899BD20665
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 15:52:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563897159;
	bh=nf3tMC7wQ5RuCZRvfP/Vxh4DTYekeHgD7c277PFuEOk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=KsfnERSRwbuBxPIuYEEJ6oGCG9vl9rEkyCNTP2Dunk1Na2KIyH/6kDITAoIPP/RlN
	 jvWWlMzcpEsv4US9TY7W/gPWdRBs8wogGrm8hdqowYgJYOc1RhdHrG75DMtOBcE+yL
	 We4YNoKIjnzpknGReR+pVPQtuJvXwcfSxCyYDbxU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732311AbfGWPwi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 11:52:38 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:53208 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728497AbfGWPwi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 11:52:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
        From:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=tvYLzMxQOS+0VzYPNU7SkuEzCyO8+2yot/ohF+n2sKo=; b=jYMIZXOksfIBOyMmh7uCKgVA7
        KMyeZxAA4C3bAl6ESGjtpGCeL1V+Rw4Ws4nts51kkidOdqpffUsMieNNdqscnW9GwFwHB31kl4PNg
        YdLpM+NdDKbnrM6Wm/ilD6KeL+tdnkVNgwMzBjJ0t8ON8twfvasY8bemhIiocYllgpo4ZZ+WEZpAs
        rRM1qOGCSRpsRbJ6vlup8GqZd+2oPzgbX06M44wo9zMRv6Pv3LO9qvezUsMCt5R7Bb+hFU5I563qI
        3o1NUO/yyBYJhTQzk7QKNLS9iBz6haIJnpLNpWChhC2aSUck0qoaOndkvcscUtIyfU3Sl9OU0eM+t
        /y3Dq/NXQ==;
Received: from 177.41.98.220.dynamic.adsl.gvt.net.br ([177.41.98.220] helo=coco.lan)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hpx5e-0007zr-HR; Tue, 23 Jul 2019 15:52:34 +0000
Date:   Tue, 23 Jul 2019 12:52:30 -0300
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Ezequiel Garcia <ezequiel@collabora.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Pawel Osciak <posciak@chromium.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Tomasz Figa <tfiga@chromium.org>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>
Subject: Re: linux-next: build failure after merge of the v4l-dvb tree
Message-ID: <20190723125230.1ca56edd@coco.lan>
In-Reply-To: <13b14eb9475de71b408d1eed3c5e69fe089deeb0.camel@collabora.com>
References: <20190723101341.751596b2@canb.auug.org.au>
        <13b14eb9475de71b408d1eed3c5e69fe089deeb0.camel@collabora.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, 23 Jul 2019 12:14:20 -0300
Ezequiel Garcia <ezequiel@collabora.com> escreveu:

> On Tue, 2019-07-23 at 10:13 +1000, Stephen Rothwell wrote:
> > Hi all,
> > 
> > After merging the v4l-dvb tree, today's linux-next build (x86_64
> > allmodconfig) failed like this:
> > 
> > In file included from <command-line>:
> > include/media/vp8-ctrls.h:25:2: error: unknown type name '__s8'
> >   __s8 quant_update[4];
> >   ^~~~
> > include/media/vp8-ctrls.h:26:2: error: unknown type name '__s8'
> >   __s8 lf_update[4];
> >   ^~~~
> > include/media/vp8-ctrls.h:27:2: error: unknown type name '__u8'
> >   __u8 segment_probs[3];
> >   ^~~~
> > include/media/vp8-ctrls.h:28:2: error: unknown type name '__u8'
> >   __u8 padding;
> >   ^~~~
> > include/media/vp8-ctrls.h:29:2: error: unknown type name '__u32'
> >   __u32 flags;
> >   ^~~~~
> > include/media/vp8-ctrls.h:36:2: error: unknown type name '__s8'
> >   __s8 ref_frm_delta[4];
> >   ^~~~
> > include/media/vp8-ctrls.h:37:2: error: unknown type name '__s8'
> >   __s8 mb_mode_delta[4];
> >   ^~~~
> > include/media/vp8-ctrls.h:38:2: error: unknown type name '__u8'
> >   __u8 sharpness_level;
> >   ^~~~
> > include/media/vp8-ctrls.h:39:2: error: unknown type name '__u8'
> >   __u8 level;
> >   ^~~~
> > include/media/vp8-ctrls.h:40:2: error: unknown type name '__u16'
> >   __u16 padding;
> >   ^~~~~
> > include/media/vp8-ctrls.h:41:2: error: unknown type name '__u32'
> >   __u32 flags;
> >   ^~~~~
> > include/media/vp8-ctrls.h:45:2: error: unknown type name '__u8'
> >   __u8 y_ac_qi;
> >   ^~~~
> > include/media/vp8-ctrls.h:46:2: error: unknown type name '__s8'
> >   __s8 y_dc_delta;
> >   ^~~~
> > include/media/vp8-ctrls.h:47:2: error: unknown type name '__s8'
> >   __s8 y2_dc_delta;
> >   ^~~~
> > include/media/vp8-ctrls.h:48:2: error: unknown type name '__s8'
> >   __s8 y2_ac_delta;
> >   ^~~~
> > include/media/vp8-ctrls.h:49:2: error: unknown type name '__s8'
> >   __s8 uv_dc_delta;
> >   ^~~~
> > include/media/vp8-ctrls.h:50:2: error: unknown type name '__s8'
> >   __s8 uv_ac_delta;
> >   ^~~~
> > include/media/vp8-ctrls.h:51:2: error: unknown type name '__u16'
> >   __u16 padding;
> >   ^~~~~
> > include/media/vp8-ctrls.h:55:2: error: unknown type name '__u8'
> >   __u8 coeff_probs[4][8][3][11];
> >   ^~~~
> > include/media/vp8-ctrls.h:56:2: error: unknown type name '__u8'
> >   __u8 y_mode_probs[4];
> >   ^~~~
> > include/media/vp8-ctrls.h:57:2: error: unknown type name '__u8'
> >   __u8 uv_mode_probs[3];
> >   ^~~~
> > include/media/vp8-ctrls.h:58:2: error: unknown type name '__u8'
> >   __u8 mv_probs[2][19];
> >   ^~~~
> > include/media/vp8-ctrls.h:59:2: error: unknown type name '__u8'
> >   __u8 padding[3];
> >   ^~~~
> > include/media/vp8-ctrls.h:63:2: error: unknown type name '__u8'
> >   __u8 range;
> >   ^~~~
> > include/media/vp8-ctrls.h:64:2: error: unknown type name '__u8'
> >   __u8 value;
> >   ^~~~
> > include/media/vp8-ctrls.h:65:2: error: unknown type name '__u8'
> >   __u8 bit_count;
> >   ^~~~
> > include/media/vp8-ctrls.h:66:2: error: unknown type name '__u8'
> >   __u8 padding;
> >   ^~~~
> > include/media/vp8-ctrls.h:86:2: error: unknown type name '__u16'
> >   __u16 width;
> >   ^~~~~
> > include/media/vp8-ctrls.h:87:2: error: unknown type name '__u16'
> >   __u16 height;
> >   ^~~~~
> > include/media/vp8-ctrls.h:89:2: error: unknown type name '__u8'
> >   __u8 horizontal_scale;
> >   ^~~~
> > include/media/vp8-ctrls.h:90:2: error: unknown type name '__u8'
> >   __u8 vertical_scale;
> >   ^~~~
> > include/media/vp8-ctrls.h:92:2: error: unknown type name '__u8'
> >   __u8 version;
> >   ^~~~
> > include/media/vp8-ctrls.h:93:2: error: unknown type name '__u8'
> >   __u8 prob_skip_false;
> >   ^~~~
> > include/media/vp8-ctrls.h:94:2: error: unknown type name '__u8'
> >   __u8 prob_intra;
> >   ^~~~
> > include/media/vp8-ctrls.h:95:2: error: unknown type name '__u8'
> >   __u8 prob_last;
> >   ^~~~
> > include/media/vp8-ctrls.h:96:2: error: unknown type name '__u8'
> >   __u8 prob_gf;
> >   ^~~~
> > include/media/vp8-ctrls.h:97:2: error: unknown type name '__u8'
> >   __u8 num_dct_parts;
> >   ^~~~
> > include/media/vp8-ctrls.h:99:2: error: unknown type name '__u32'
> >   __u32 first_part_size;
> >   ^~~~~
> > include/media/vp8-ctrls.h:100:2: error: unknown type name '__u32'
> >   __u32 first_part_header_bits;
> >   ^~~~~
> > include/media/vp8-ctrls.h:101:2: error: unknown type name '__u32'
> >   __u32 dct_part_sizes[8];
> >   ^~~~~
> > include/media/vp8-ctrls.h:103:2: error: unknown type name '__u64'
> >   __u64 last_frame_ts;
> >   ^~~~~
> > include/media/vp8-ctrls.h:104:2: error: unknown type name '__u64'
> >   __u64 golden_frame_ts;
> >   ^~~~~
> > include/media/vp8-ctrls.h:105:2: error: unknown type name '__u64'
> >   __u64 alt_frame_ts;
> >   ^~~~~
> > include/media/vp8-ctrls.h:107:2: error: unknown type name '__u64'
> >   __u64 flags;
> >   ^~~~~
> > 
> > Caused by commit
> > 
> >   a57d6acaf352 ("media: uapi: Add VP8 stateless decoder API")
> > 
> > I have added the following fix patch for today.
> >   
> 
> Looks good, thanks for the fix. I wonder why this
> got triggered with VP8 only, and not with MPEG-2.

I suspect that this got triggered by some change at linux-next, as
it built fine here on the top of 5.3-rc1.

Patch was applied earlier today.

Thanks,
Mauro
