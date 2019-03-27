Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F3D4C4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:59:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12829206B7
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:59:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="Ofmje5At"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389738AbfC0SPB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 14:15:01 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:45569 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389713AbfC0SO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:14:57 -0400
Received: by mail-qt1-f195.google.com with SMTP id v20so19948889qtv.12
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2019 11:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=/GQ3PoXyTSRUtE1BhjDpnMLjUgf+n2ekMVq0YuFfjJA=;
        b=Ofmje5At1uBCTAvYa4Ci2jETuoPaMHv7iGQlVPbYHuuEc23giA3sFtE6B0YUKRxG2Y
         LP7ILExr1YL+bhZln/f1sSjFWyezHaiRLeCTC05Aus4ox29UPbldbyGBio1s+rh7BRA2
         +GpmMP8QRMqPvgcMZeegz07sjdVv0pKbbvN/FHO/tcq8i1OqmbxV30mwkIQYLpxwba8c
         xCrXIcdaqx8mQLB8lRL9iRSGGl+fcrLWy/u63Z+qq5OWfVMkaynEOKMEE5bc60LwG7mQ
         kAVIk9Q2IiSuvOlpPfLOc04Gi46DRN8rfm+wH7QMrpEG1ZCfy1Ljsyd2bndfAkEfaboC
         kvlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=/GQ3PoXyTSRUtE1BhjDpnMLjUgf+n2ekMVq0YuFfjJA=;
        b=kS1EY+3W7ZrnsYNRgoD6bo54Li5WiL1tXr8q1+dzK2VX92j4+smrKptvediFrypvme
         /V6hI8CTyLvcXqDN49+xKhv+E8Uj46QeqIbXwW7yherDhIJ6DLAmeGKUObBdBw0pqJXU
         BAJUcb2b04aRn9TW1JeNPI7iLuq5Nl+ApQbvIa//gqXTEgq5Hvl00Xv1LbOzfwLuKz3T
         6Rz5c8gyhsXKoypXVmphyaKI9vU7HWq3LOsUUT0KZN9WCwW6c3963Q+3zQN69pj7ETwE
         yJ1A2KpokrmrJDyM/Dh4zRxjld34BlAgd+GxTmpS2tnIaDR4XshhuAgxX7PNLaSGYhKF
         7+ig==
X-Gm-Message-State: APjAAAXylMchBURMPpoy4dOAKOttjmCROb6pidcoy0/4KLkpf9qlwse5
        BHZr7mXvRxtt63jCjdRmPFSPFw==
X-Google-Smtp-Source: APXvYqxvImDs6yLw9cyOtwrI4l2k7I5+t+hMucuo2Aq8VcBmeWs3CDLnuXrGtv9arzeW3onNM6oBFg==
X-Received: by 2002:ac8:2692:: with SMTP id 18mr31963871qto.343.1553710496568;
        Wed, 27 Mar 2019 11:14:56 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id r201sm5912689qke.37.2019.03.27.11.14.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Mar 2019 11:14:56 -0700 (PDT)
Date:   Wed, 27 Mar 2019 11:14:52 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Jiong Wang <jiong.wang@netronome.com>,
        Alexei Starovoitov <ast@kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, oss-drivers@netronome.com
Subject: Re: [oss-drivers] [PATCH AUTOSEL 5.0 192/262] nfp: bpf: correct the
 behavior for shifts by zero
Message-ID: <20190327111452.379db173@cakuba.netronome.com>
In-Reply-To: <20190327180158.10245-192-sashal@kernel.org>
References: <20190327180158.10245-1-sashal@kernel.org>
        <20190327180158.10245-192-sashal@kernel.org>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Mar 2019 14:00:47 -0400, Sasha Levin wrote:
> From: Jiong Wang <jiong.wang@netronome.com>
> 
> [ Upstream commit db0a4b3b6b83a081a9ec309cc8178e5c9b4706a5 ]
> 
> Shifts by zero do nothing, and should be treated as nops.
> 
> Even though compiler is not supposed to generate such instructions and
> manual written assembly is unlikely to have them, but they are legal
> instructions and have defined behavior.
> 
> This patch correct existing shifts code-gen to make sure they do nothing
> when shift amount is zero except when the instruction is ALU32 for which
> high bits need to be cleared.
> 
> For shift amount bigger than type size, already, NFP JIT back-end errors
> out for immediate shift and only low 5 bits will be taken into account for
> indirect shift which is the same as x86.
> 
> Reviewed-by: Jakub Kicinski <jakub.kicinski@netronome.com>
> Signed-off-by: Jiong Wang <jiong.wang@netronome.com>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>

Nope.
