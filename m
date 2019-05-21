Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C595C18E7C
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 20:56:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA417217F9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 20:56:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n2tCXEko"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728010AbfEUU4i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 16:56:38 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44729 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727222AbfEUU4h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 16:56:37 -0400
Received: by mail-pg1-f194.google.com with SMTP id n2so93221pgp.11;
        Tue, 21 May 2019 13:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tQTbtkzqmYegpqRvxuRfeadiqq1RDM6i5Y0h/tP6c/0=;
        b=n2tCXEko04S+of6kuuGqYQOABJoTLuospRLNdBxGSE1wrMSSRSsgMSH3y9PmVXfHpr
         swlFKR6aBYjVBdKIFHNuBj/EjZqJ4ZV2gBcfV6MoMAOtkcQJkvMKl/UwvEvI92btiMzr
         0FhC1urrNN5rEocDEgpDYQyYGbgxgkEse8sXbOucvvJVAUxPmkO2aqNVQDtdjScBFXSI
         x48gTm4C2ZtREIOs8wA6Zj/pZqcWGyyn1a1BgX/IQ9kTc+fOLmPDNyAg22j/qOwD7I0F
         QvHvKyb+OOWB5ocjaFSQRsy/dQP17jtF4De6GqhbMGIszT/pTtbtBHCBKkLWwMgkDVsb
         1drg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tQTbtkzqmYegpqRvxuRfeadiqq1RDM6i5Y0h/tP6c/0=;
        b=eRtnWe5XLwB0xe6BNZIQ+OQ+MFNRltWhzzzxWOZadhAY9NIi9Ps328TfngU6/9+lNM
         gnp/nDWLTa69c6wEjC6JGGrnSdocHF8D6ImNXCZoVL9oPQQpdI8NzYHSYoQVtlnG3vOG
         XLpqYCrJ2NeG3GFSYVjYoCqex6k7klE3J6+T/lsOiQ7mfToyFzHBjZ/x7tLxYthK5SSK
         Gp4J6hdyytCWrs80H8VWWPO6dskgPQSFXCYkatpTeXAOnpiizk7jTmgj30KGPciJ/9WA
         RufVf6MxoiaIKWUZSeTJQC5ZN18jTlbJI3KHEOMpaEsFGPJcmQu0YijYl9reNzjVDE3n
         uMpA==
X-Gm-Message-State: APjAAAUhYQApkzJhG4Av/hWJ3cqcfIawJK1MW//X7IDxTBo1PY62CvbJ
        6NnG3hj7uZffNlicSQaQOz4=
X-Google-Smtp-Source: APXvYqzCbeQQPsRl+Dxcp8TJo9Iccuz+QYV9zYovrc3LO51FjRCSOGTygo5cSic7PxrWCrf9neTH9A==
X-Received: by 2002:a63:e042:: with SMTP id n2mr83608716pgj.201.1558472197114;
        Tue, 21 May 2019 13:56:37 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:200::1:1eff])
        by smtp.gmail.com with ESMTPSA id d15sm27976791pfr.179.2019.05.21.13.56.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 May 2019 13:56:36 -0700 (PDT)
Date:   Tue, 21 May 2019 13:56:34 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Kris Van Hees <kris.van.hees@oracle.com>
Cc:     dtrace-devel@oss.oracle.com, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        daniel@iogearbox.net, acme@kernel.org, mhiramat@kernel.org,
        rostedt@goodmis.org, ast@kernel.org
Subject: Re: [RFC PATCH 00/11] bpf, trace, dtrace: DTrace BPF program type
 implementation and sample use
Message-ID: <20190521205633.jbnewdpz7p772sfa@ast-mbp.dhcp.thefacebook.com>
References: <201905202347.x4KNl0cs030532@aserv0121.oracle.com>
 <20190521204848.GJ2422@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190521204848.GJ2422@oracle.com>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 21, 2019 at 04:48:48PM -0400, Kris Van Hees wrote:
> As suggested, I resent the patch set as replies to the cover letter post
> to support threaded access to the patches.

As explained in the other email it's a Nack.
Please stop this email spam.

