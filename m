Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E057C4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 21:42:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 148832146E
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 21:42:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="sGZfP/z9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727837AbfI0Vms (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 17:42:48 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:39493 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725990AbfI0Vmr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 17:42:47 -0400
Received: by mail-pg1-f195.google.com with SMTP id o10so4137993pgs.6
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2019 14:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=Lzcnw0iAcIFwZNCYEwiqETTo7mFYOXKonShWkT8groo=;
        b=sGZfP/z9N7kBYff/yn481rZ/m6Z9TK6lqaAfFkUlClJYaX8LJPJD0042nr+RR3kNgl
         L8pFTcb0BAOChMz1+gAVJoDsfySeQo0Fnr0M1vXJFjjh8Z5W4DCICoF+7zkY5cJm0Nyf
         y+AnIpfEzF2ChKoi9ajpC/gQP/wGShzwwUhQIKwQoa/Hqimb6p5zQDZpSzHQEm7kOvJ8
         9mkCLMkFNfZzwHE5YXzSjvy/ik4EG5Q3GDmViRu29WVrQApCyARAWK969W8a7bTabQi6
         WqByiOseyL9LLbeZy4lv7mAJKqWfhCX08Daalfg5JBz1TRuQaXpsIpIwuzozUVgYh01S
         +EfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=Lzcnw0iAcIFwZNCYEwiqETTo7mFYOXKonShWkT8groo=;
        b=F1YJnMPuyULydZXVH/7ZmKPF/LW4ZpwEC05/w+ooh+upI4CZ3PmsEgY9XbMhrwZLRM
         HFo1zcU/hb9mMuWJ3Diqm4tAr99YzUPvWJgXH+807oc+WVaNTuCH8OhQCiaSDZRSGGIf
         pNos1oNJ2werEB+s35Z3L/KJ4rbn5mBillaCrUyN+UFWUMSryfG9hjsCFUtp/vqOIPsR
         8FiA+0vTUrV8yRLV4g+2N0y3JCZLrsXb3ZoyVkueo0P+jRfbLTdY9Ul4zRYy1e0FIrSR
         HcF8/zcQTR1hkwZcgODIyy4y6Yafc+S7hE2Xcuzd72lW89B9tTEGrKUwtqKi5GEFtEa6
         z4Eg==
X-Gm-Message-State: APjAAAW4VabvHnFw/P+ykRH/ZySwrBIqwLFORC4rvtkFZUjuam94I/d0
        Rj3FhmHrULel0mViEWVAlkB6PA==
X-Google-Smtp-Source: APXvYqylvxizWriFlZFI3My3E7wjF1M17Xv3jfridbykbRDhmf/+GPf8eTOyqqe9JtmyjBQw57nNfA==
X-Received: by 2002:a65:628a:: with SMTP id f10mr11289856pgv.155.1569620566828;
        Fri, 27 Sep 2019 14:42:46 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id y138sm4035112pfb.174.2019.09.27.14.42.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2019 14:42:46 -0700 (PDT)
Date:   Fri, 27 Sep 2019 14:42:42 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     Navid Emamdoost <navid.emamdoost@gmail.com>,
        netdev@vger.kernel.org, oss-drivers@netronome.com,
        Navid Emamdoost <emamd001@umn.edu>, Kangjie Lu <kjlu@umn.edu>,
        Stephen A McCamant <smccaman@umn.edu>,
        Colin Ian King <colin.king@canonical.com>,
        "David S. Miller" <davem@davemloft.net>,
        John Hurley <john.hurley@netronome.com>,
        Pablo Neira <pablo@netfilter.org>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v3] nfp: abm: fix memory leak in
 nfp_abm_u32_knode_replace
Message-ID: <20190927144242.7e0d8fde@cakuba.netronome.com>
In-Reply-To: <1cde6417-5942-598b-3670-c0a7227ffe25@web.de>
References: <20190927015157.20070-1-navid.emamdoost@gmail.com>
        <1cde6417-5942-598b-3670-c0a7227ffe25@web.de>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Sep 2019 14:12:42 +0200, Markus Elfring wrote:
> > Updated other gotos to have correct errno returned, too.  
> 
> How do you think about to add a jump target here?
> 
> 
> > +++ b/drivers/net/ethernet/netronome/nfp/abm/cls.c
> > @@ -176,8 +176,10 @@ nfp_abm_u32_knode_replace(struct nfp_abm_link *alink,
> >  	u8 mask, val;
> >  	int err;
> >
> > -	if (!nfp_abm_u32_check_knode(alink->abm, knode, proto, extack))
> > +	if (!nfp_abm_u32_check_knode(alink->abm, knode, proto, extack)) {
> > +		err = -EOPNOTSUPP;
> >  		goto err_delete;
> > +	}
> >
> >  	tos_off = proto == htons(ETH_P_IP) ? 16 : 20;  
> 
> -		goto err_delete;
> +		goto e_opnotsupp;
> 
> 
> > @@ -221,7 +227,7 @@ nfp_abm_u32_knode_replace(struct nfp_abm_link *alink,
> >  
> 
> +e_opnotsupp:
> +	err = -EOPNOTSUPP;
> 
> >  err_delete:
> >  	nfp_abm_u32_knode_delete(alink, knode);
> > -	return -EOPNOTSUPP;
> > +	return err;
> >  }
> >
> >  static int nfp_abm_setup_tc_block_cb(enum tc_setup_type type,  
> 
> 
> Can such a change variant be a bit nicer?

Definitely not.

Looks good as is, thanks Navid!
