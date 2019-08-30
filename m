Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BD94C3A59B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 19:37:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D114321897
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 19:37:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20150623.gappssmtp.com header.i=@networkplumber-org.20150623.gappssmtp.com header.b="XKAVN/4I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728308AbfH3ThY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 15:37:24 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:37264 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727979AbfH3ThX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 15:37:23 -0400
Received: by mail-pl1-f193.google.com with SMTP id bj8so3805317plb.4
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2019 12:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3kZ/NJnyXN0yquM09pSH+z00YFv7ov+AjZa3Udsid30=;
        b=XKAVN/4IVjAB97Ac7Zope7eu3O+qGHxH5q3Cb6OdxMaikpodOqCLdST4a2QVGgXQzv
         6mtabjSRdEG+JN0/+cl+OBYxsrnQwMhA/Nu0rDhUXcorw2fq+hWIUHFpBwqtmxIHkgCF
         Rk6fkUqhmSeCvBmLwuSSSHPaVjdk8CE8G55kQXvFlpn/E/xrQz9Ll2x0bpseuofiOoO2
         5F0BNHn+07IaqyvsqaE9NHCIj0p7FnVaYZvtwDFAncBHjzJFDJJW3ze3O3u2qhni+aMa
         QEr6ug2H0TagdlpBs+qNaFp02VjaRzi8VckN4nRSUEzz3i9TfqPs3zzsxrR0wfHOQm3W
         RSkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3kZ/NJnyXN0yquM09pSH+z00YFv7ov+AjZa3Udsid30=;
        b=qjOCMggCwC44kerS7Gl4LYg3lQdBgVw/KA8wzYMYdcXGJNFqEfMLvcNCe95h8RMO9J
         eMjDSddd1sMqiTUI1A9gzADvuSEaE1t8atj0v8nvW1pBINcJZRsG+8YpfiwyH5eM4Hsx
         3yVh1ueiA9GiJqqLnVffAzKL9/m+LOaKZE2iVqc2tWjkv0MMm5xGnEy9f4Y48Khw7QUj
         GCYYRCjqTgHc6YpXI6SzkFmcN2tEc/kKBaXUheX3C1kkF/7VGUTDgvR3BCQxXHxn6D05
         PgTcmB84zVOqNYy/QZpRd6/Tfmpm5QoAl/DE/vouBiC3Uhkg1vERWg6PZN7+FgEE3yb0
         aXSQ==
X-Gm-Message-State: APjAAAV3vtS5qZ/Fhc6LG9xBUFU/tlb3LwcBVkzLGnV7BhUSp4qm0DKY
        SR0KfD/DciAvcM1Om0YEws1Grg==
X-Google-Smtp-Source: APXvYqxbvsl1y67xAv7DbANaWYAdJpu+TDBENsfl1jbfvYqXx+hNsHilibQnUC3wAw7ZTmd/etNbDg==
X-Received: by 2002:a17:902:f64:: with SMTP id 91mr17373110ply.334.1567193842913;
        Fri, 30 Aug 2019 12:37:22 -0700 (PDT)
Received: from hermes.lan (204-195-22-127.wavecable.com. [204.195.22.127])
        by smtp.gmail.com with ESMTPSA id v8sm2650838pje.6.2019.08.30.12.37.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2019 12:37:22 -0700 (PDT)
Date:   Fri, 30 Aug 2019 12:37:20 -0700
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     David Dai <zdai@linux.vnet.ibm.com>
Cc:     jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        zdai@us.ibm.com
Subject: Re: [v2] iproute2-next: police: support 64bit rate and peakrate in
 tc utility
Message-ID: <20190830123720.167de780@hermes.lan>
In-Reply-To: <1567192037-11684-1-git-send-email-zdai@linux.vnet.ibm.com>
References: <1567192037-11684-1-git-send-email-zdai@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Aug 2019 14:07:17 -0500
David Dai <zdai@linux.vnet.ibm.com> wrote:

> +			if (rate64) {
>  				fprintf(stderr, "Double \"rate\" spec\n");
>  				return -1;
>  			}

The m_police filter should start using the common functions
for duparg and invarg that are in lib/utils.c
