Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7608C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 13:14:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98AF920673
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 13:14:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Db2v8fh7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729985AbfHTNOa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 09:14:30 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43272 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728595AbfHTNOZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 09:14:25 -0400
Received: by mail-wr1-f67.google.com with SMTP id y8so12346616wrn.10
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 06:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=NIB0yDauqd7cwqCFZ5Bm7WKT8Vd6y3coQ7vww6yLLC0=;
        b=Db2v8fh79KgGWcGUA3kDE66gzOCT6FcDNi6Bb7eEih7k+EujVQRBiOxhPga02sdmxP
         8DgrEQmYW8N8CnvtPdaG/cconVUDrt92vqtd407lseGY38Rv70P2nL8lBbW+BPo64XZI
         E2A6lsLnelEjqhg8J4dLVM0Yz0ApABa5ryRlWklh2gCiB1mbp5+c0O5RnqeZdplIBtYv
         ro31NpEh+xiXkAE3ZvIgAYccd6Mp+0GmI+uzT9ejeOAmKuS3z3a8Gv1vNdQYdyKRLBmf
         ZyDuguoiM/+FAC0P5EHE2xg6o/ZPxVdOpmJdC8dq0UNY/rrpavkEfosloYrn0VaOZdkP
         yfzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=NIB0yDauqd7cwqCFZ5Bm7WKT8Vd6y3coQ7vww6yLLC0=;
        b=EUBiegeXmSKtsEL4BidbZnSdZe8MpxTdgbjsuRe5+XiIk1YLDJfUnv19gN4xUyHKHR
         hqPc34yROtLBezy2ZmFZBbq5M36PElKIzO6gOCA5ZVGXoImRT+Sb8yj5/1vwhPlmJSLz
         UVohAeAAu6ANkSWPLRPC242mIC+Qv/gLrBRU5R7O0kVA2D1LNIn0udkIM+BsQrELF2oL
         az19GTKaOy6ZuNidKj3IWs1qK+XJS2P/jPMOZ5jrqBA+LPEXoZsajO439PkTXDpZskKo
         /1IjfWKt7R4BEXKPOHIv1d/pq3owD6p5PVmHVvlMIRzzSG0IJ3hFWKQKNHawuwhFa8FC
         qMTA==
X-Gm-Message-State: APjAAAVMa9fwB19BmgInwCUCTCq5fkALDlHbjCaqtpIRe3Fbf/iJ0CW7
        UQmxj7XiMpcdnJmPL3N7sN0=
X-Google-Smtp-Source: APXvYqyuX3spgjiH3WVjaq/Ko9mh6w+xlZcE68o6M5aki7mj2mLW9wBqmdLLtzUtLeMGVM6nEK9VNQ==
X-Received: by 2002:adf:ce8d:: with SMTP id r13mr26400291wrn.37.1566306863843;
        Tue, 20 Aug 2019 06:14:23 -0700 (PDT)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id u186sm38200834wmu.26.2019.08.20.06.14.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 20 Aug 2019 06:14:23 -0700 (PDT)
Date:   Tue, 20 Aug 2019 15:14:22 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Sebastian Duda <sebastian.duda@fau.de>
Cc:     linux-kernel@vger.kernel.org, lukas.bulwahn@gmail.com
Subject: Re: Status of Subsystems
Message-ID: <20190820131422.2navbg22etf7krxn@pali>
References: <2529f953-305f-414b-5969-d03bf20892c4@fau.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2529f953-305f-414b-5969-d03bf20892c4@fau.de>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 20 August 2019 15:05:51 Sebastian Duda wrote:
> Hello Pali,
> 
> in my master thesis, I'm using the association of subsystems to
> maintainers/reviewers and its status given in the MAINTAINERS file.
> During the research I noticed that there are several subsystems without a
> status in the maintainers file. One of them is the subsystem `ALPS PS/2
> TOUCHPAD DRIVER` where you're mentioned as reviewer.
> 
> Is it intended not to mention a status for your subsystems?
> What is the current status of these systems?
> 
> Kind regards
> Sebastian Duda

Hi Sebastian! ALPS PS/2 is a driver for ALPS touchpad. They can be
found on more laptops. And ALPS PS/2 itself is not separate subsystem.
It is just driver which is part of kernel input subsystem with mailing
list linux-input@vger.kernel.org.

-- 
Pali Rohár
pali.rohar@gmail.com
