Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B027BC7D619
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:40:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E21072476B
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:40:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="b0T6JzCx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728643AbfLMRw2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 12:52:28 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:46287 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728550AbfLMRw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 12:52:26 -0500
Received: by mail-lj1-f194.google.com with SMTP id z17so3556471ljk.13
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2019 09:52:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=BOTadHFmyQTuyfnwzSO5t/8LbI/7laK+kqej1EbG7+k=;
        b=b0T6JzCxMhVY13DLGA2xcpsls2Z66ZtChJQ7elMsepKxbxoshw3HJbTwpry9VVoxOr
         eBB9yEodODAt9/hYOjjtM0bB1EjKSZt5v/CVKTY4R41s+NG+sZv6E9GqQWkgbDuM9jGu
         gM6UucCGu9jUQXJaF+0TnEz0TwSikILJB3HnSrZ4qS1rtC6O//j5AOzEvXPBT5KNM7Uq
         hHF6u3W3K44574yMXNuYOtKKC9hkFWBROtVL1sk9B28Sz2AUMhcXRwBVAAhUiAYtBhrw
         bfAz8few88T/ksVKihwLdlrjrNkE7QzvbMTZTnWjJ5cB8UrVpxrIeT6eQpXgweuJHoiY
         ueFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=BOTadHFmyQTuyfnwzSO5t/8LbI/7laK+kqej1EbG7+k=;
        b=iZWbrwgIPmPzUfBDVAboTkep+dhi06/j2dhoChXibrFpG/sERDRR2qmcFLY/z9ne4L
         izBBp7s88CaGuz3Nf8WiOLnCMQ1z4xVadH8qOiMS/GCc8P6eKeaDQcvsyrsHcBNiQwac
         yCWcYpHkJok2rtcJ96m7TpclWKIQJ5beOb4AVJEPDaldPE+i86/CD5LmMqGe+IcAes4p
         ONm4iT4agRSngz/G8ZfF7Xsd4yVnPq41VxuoVKNdPD7GjleX+8B41yGC6gwlovpLT9bc
         oCZN8lKz1BPnKMGF+dVZRCYoFB6L3Kuidosc3rljCRPfMQy36Qv2p+dNmjiWO7iVexGq
         az8w==
X-Gm-Message-State: APjAAAVT+4z0AcUqzbF2cwQQnSW7TkT9ORGclJCWgSyihVcm6fTJKaUj
        NVwJl176lW5mSCrfmb7I8qvSlg==
X-Google-Smtp-Source: APXvYqzNDAopUxd1xthpyicYmxDmbwcbiYO9ORSI/3KYNsxJbzSpz1Gg81uAjBuLDH9+jOSMfXWeKQ==
X-Received: by 2002:a2e:995a:: with SMTP id r26mr10660526ljj.78.1576259545044;
        Fri, 13 Dec 2019 09:52:25 -0800 (PST)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id m21sm4859062lfh.53.2019.12.13.09.52.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2019 09:52:24 -0800 (PST)
Date:   Fri, 13 Dec 2019 09:52:17 -0800
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Shuah Khan <shuah@kernel.org>,
        Simon Horman <simon.horman@netronome.com>,
        netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Paolo Pisati <paolo.pisati@canonical.com>
Subject: Re: [PATCH] selftests: net: tls: remove recv_rcvbuf test
Message-ID: <20191213095217.14588890@cakuba.netronome.com>
In-Reply-To: <20191213103903.29777-1-cascardo@canonical.com>
References: <20191213103903.29777-1-cascardo@canonical.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Dec 2019 07:39:02 -0300, Thadeu Lima de Souza Cascardo wrote:
> This test only works when [1] is applied, which was rejected.
> 
> Basically, the errors are reported and cleared. In this particular case of
> tls sockets, following reads will block.
> 
> The test case was originally submitted with the rejected patch, but, then,
> was included as part of a different patchset, possibly by mistake.
> 
> [1] https://lore.kernel.org/netdev/20191007035323.4360-2-jakub.kicinski@netronome.com/#t

Ah, damn, you're right, sorry about that!

> Thanks Paolo Pisati for pointing out the original patchset where this
> appeared.
> 
> Cc: Jakub Kicinski <jakub.kicinski@netronome.com>
> Fixes: 65190f77424d (selftests/tls: add a test for fragmented messages)
> Reported-by: Paolo Pisati <paolo.pisati@canonical.com>
> Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>

Acked-by: Jakub Kicinski <jakub.kicinski@netronome.com>
