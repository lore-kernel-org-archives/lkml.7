Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67045C31E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 01:28:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27E152082C
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 01:28:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QxQiLwoo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbfFRB20 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 21:28:26 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42100 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726095AbfFRB20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 21:28:26 -0400
Received: by mail-pg1-f196.google.com with SMTP id l19so6713830pgh.9
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2019 18:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EhVn2VpMWMF3z6W4xlxwl8wypc2+4cPuZsN0Q8XyuuU=;
        b=QxQiLwooXqMRIkh11AjjQpzoWU1haTiRRfs3v/EaP87xSPpKa5JBxenQkYqUhXEx6h
         kpkbHAPqme66p1Q341yD7s78oKCSHZNbtW+zdGku+s0PPSEg/N6Qm03TgetlcHx4TVbm
         xYbt5LQ9uNSfw7VHrymOZwu7PAirRKyhzC1CJLfiA5gaPz+PzM205K7+UjJt9CREqGLi
         ae96RwBqoMwWiMtBVkevOr02W/5NRlj9qAQsr2K1562c0CKuUfGB3UWJAQzknBqI/X0k
         O7NEMWsFgncoYbAlTl0F6/bux/7NUyVv3bT+YZkmsVAJkZdQhZA9809soAHcBiPWrxYB
         zUBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EhVn2VpMWMF3z6W4xlxwl8wypc2+4cPuZsN0Q8XyuuU=;
        b=asKAKfxZJhdlWehpUtTRk2gn+S4F9PIenUtjc8otsNX5wUFzvlKLbpdscId9Pc0rKs
         dqJdvoBF6Vi5B0qkRsVc3LpF8YakMVWWIaJjXtl9x6lIJ0x4CDZyYgwpN05aLEbfy8js
         vgHqjdp0r74cH+167x3nKRl4VbWIOc3Uv6yQix8Re2OlGmQpH0xvFTzni3dUGZ7VHKEt
         +FfoQcfBdvUClN+8I0ybfIpUdB+M9gWw80WtwIHPxWccSUYayOHGNwWqBQgP/8dWquR2
         v/W0bzK2a400kUdKdPUhPzmDMHM+Qy0/jflJINF+xtZQpwv58FEbq2oe9TbaBgpaSXva
         Ojfw==
X-Gm-Message-State: APjAAAXgJD4wKUiBVezJqMz7E0C4Bq4mUFaUbHGVV0QFMxhlFk2jFxek
        1ih3/BSQGvOmNoFQ2AJlZBfZUytU
X-Google-Smtp-Source: APXvYqzwqhVNBJpFvgKBoGS/o0RnWQY7px1RA77j748IdScaUq3udhxsYRuSfDF2Jy9SBRk7xBSF7A==
X-Received: by 2002:a62:2643:: with SMTP id m64mr113828678pfm.46.1560821305718;
        Mon, 17 Jun 2019 18:28:25 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.92.187])
        by smtp.gmail.com with ESMTPSA id k4sm3153187pfk.42.2019.06.17.18.28.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Jun 2019 18:28:25 -0700 (PDT)
Date:   Tue, 18 Jun 2019 06:58:20 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>,
        Nishka Dasgupta <nishkadg.linux@gmail.com>,
        Mamta Shukla <mamtashukla555@gmail.com>,
        Emanuel Bennici <benniciemanuel78@gmail.com>,
        Shobhit Kukreti <shobhitkukreti@gmail.com>,
        Puranjay Mohan <puranjay12@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8723bs: os_dep: ioctl_linux:  Make use
 rtw_zmalloc
Message-ID: <20190618012819.GA7963@hari-Inspiron-1545>
References: <20190616053250.GA16116@hari-Inspiron-1545>
 <20190616071522.GE28859@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190616071522.GE28859@kadam>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 16, 2019 at 10:15:22AM +0300, Dan Carpenter wrote:
> On Sun, Jun 16, 2019 at 11:02:50AM +0530, Hariprasad Kelam wrote:
> > rtw_malloc with memset can be replace with rtw_zmalloc.
> > 
> > Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
> > ---
> >  drivers/staging/rtl8723bs/os_dep/ioctl_linux.c | 12 +++---------
> >  1 file changed, 3 insertions(+), 9 deletions(-)
> > 
> > diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
> > index fc3885d..c59e366 100644
> > --- a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
> > +++ b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
> > @@ -478,14 +478,12 @@ static int wpa_set_encryption(struct net_device *dev, struct ieee_param *param,
> >  		if (wep_key_len > 0) {
> >  			wep_key_len = wep_key_len <= 5 ? 5 : 13;
> >  			wep_total_len = wep_key_len + FIELD_OFFSET(struct ndis_802_11_wep, KeyMaterial);
> > -			pwep = rtw_malloc(wep_total_len);
> > +			pwep = rtw_zmalloc(wep_total_len);
> 
> We should not introduce new uses of rtw_malloc() or rtw_zmalloc().  They
> are buggy garbage.  Use normall kmalloc() and kzalloc().
Hi Dan Carpenter,

Sure , will  resend this patch with suggested changes.

Thanks,
Hariprasad k

> 
> regards,
> dan carpenter
 
