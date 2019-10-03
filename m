Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0C14C10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 15:12:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 778A920679
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 15:12:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rkB+TAk0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729658AbfJCPMm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 11:12:42 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:41416 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726364AbfJCPMl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 11:12:41 -0400
Received: by mail-qt1-f193.google.com with SMTP id d16so4058239qtq.8
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2019 08:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=doUapdd+t8q28td1ePGT0x1egG3GBDqT1obBNFclp3s=;
        b=rkB+TAk0/GCkhRFGSfrPcLIYCh+incOaFYSQbR+OLj7OWhc5Z2PqpULOAkSmVNxxij
         wzMaza2E5WbwRzTD/Lel4kN2ahqEbAPqgUZlq9UeiLWNaAzkHimKD/WaN0zN5i381oYx
         dC2IM5CafP3P8MDghHhys5AM29Mej4tVGd8siWDjscUbjbHpVPuNIP2q4pxomQl6Mk7t
         8Wh2Cu0ZNoWLeOJx+cjH7SRPRJvTHn2Pxz8Lh0pIDljlR2IZP9y92BoSLn563o3aDcJJ
         F94D7sYAYUUqTIzVxbfjpQ/3Kb9sTkAP4x/zE+ZTRNC/u6o8RvPuD215lvofkNcA6QAA
         RaiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=doUapdd+t8q28td1ePGT0x1egG3GBDqT1obBNFclp3s=;
        b=AQb9LcHsbE3MNFGnEfrtC9Jrba3mY+bV8m+0VPJBzKtmVtKjfki2VocWyui6VukwGi
         u3gbeL6h2GQTSNKHbR/ex/+Tr9fyKWQdop0kek55ylDrosUWytTVF+s5wTE6Jyj8fSR1
         R3C11axAyVjNVPyMatk2rcmOVK64AtvXFLJBo4JsU5XzHbDFC6bS1zjP3NkE4RwZqbYR
         5XJJmKuzphphayWu6eGVWeYMY1qr1eJDer7Xx/d87E9DPp0uWnvJQnoEpPZWyB4ZjGuE
         9e06RA4ZUEDPYtzMYsz07rCkb/qU+Z6rrINUt8oTNa0+EErwuNAORJPtDYUYmRQWAMB1
         602g==
X-Gm-Message-State: APjAAAXnnnWjlGBI6XUGf0l61gYIrS2eAEsV+kmUHduErwzdQ+ellWtU
        8gkAdCTIkKwWBV1awsxuFL80XxMq37A=
X-Google-Smtp-Source: APXvYqxccZzwmhoM6CSMB64CFMTyUpNKgcyYZ8ETRu6+Nd+/8C02qvSJzmaH1gfcTc7CzwEhi14q8A==
X-Received: by 2002:aed:38c7:: with SMTP id k65mr10637835qte.251.1570115560373;
        Thu, 03 Oct 2019 08:12:40 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id b16sm2155084qtk.65.2019.10.03.08.12.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Oct 2019 08:12:39 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Thu, 3 Oct 2019 11:12:38 -0400
To:     Greg Kroah-Hartman <grekh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: 5.3.y stable branch has been bumped to 5.3.3?
Message-ID: <20191003151237.GA2887046@rani.riverdale.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg, I'm seeing what looks like an extra commit [1] in the 5.3.y branch
post the 5.3.2 tag, bumping version in the Makefile to 5.3.3.
Historically the version bump has only happened once all the stable
patches have been applied and the new version is getting tagged -- is
this a mistake or intentional change in process to pre-bump the version?

[1] https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=linux-5.3.y&id=9c30694424ee15cc30a23f92a913d5322b9e5bd3

Thanks.
