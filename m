Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAD37C43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 21:03:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E180206E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 21:03:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="qSDXP8RP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbfDZVD3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 17:03:29 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:45014 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726134AbfDZVD2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 17:03:28 -0400
Received: by mail-qk1-f194.google.com with SMTP id y5so2707954qkc.11
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2019 14:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=cwXLRcDq1ftZ0cdqNvS8Nrv6hGkLzbIaQeIbceSh3VA=;
        b=qSDXP8RP+3jGx7/HxfdmdnlCN+JBOFZgCTg81s040wqOcV0tVsCkcFy4zEDpsZUmiI
         RQHHrYtdrXIv1PvgPoApV1zS1ZQqDH9S5d7SCc6V3j9skSX/YakGVzNIEVULJHIlUD+e
         IsJbS9oenWMzCe1lZOZscNPChNvj4WLqhVb0nNi+qkz+HApGZsg6w/ORPJXfJkhKg+3L
         zE0aFgjM4Qw7+yZbTXU2qbVdhqnGuuFBoVail9zcneHYsDkkR8qajmFRJMHCbKUZxJ1w
         AwAV7Gh23H3BaypgWqnaYcsEnGoFrhazOq0wUbY1WDNBlIR1LVVlBVGhhjGELR6vVTPy
         exmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=cwXLRcDq1ftZ0cdqNvS8Nrv6hGkLzbIaQeIbceSh3VA=;
        b=kwgOKX1DwBeD57PjFimcQNVtuBE2n91taRecXz0WnTxLJbZT9kEEl9EeZRUapuaPdp
         L2697WIIkiXu/VP2ziEeUrXp3p7GgPsR/W1px+Yms+nchsYR92EEJAHRa3rxl+fpwa7Z
         ZQNpx5alUYyHfnFKpRwhX7Oo89GX/3mnFN7LOblenWRLIGVQeIpZIquJDdg9takAQ3U4
         wkgr/eoCRQBahUkQ3TOLnv6ECQttNwYyZcWcmH8bPvIuQEic/S/zHpVTibtedebUNQVL
         XL/ubZTCtd+rX4N65ClAg0HVAdh9HztKl2rLkxhjb2cVtxLtNmE6fd9y4++LoTlV2VCY
         xU0g==
X-Gm-Message-State: APjAAAWYBamvr3hWzru2xEvKWYmD8Z9bkrGE3kIa40kAWE6tZv527w5M
        rQfIp4FUrol03HqIHMQJ6OycAg==
X-Google-Smtp-Source: APXvYqwgsrLSCzdkVmWKhF3ydsamBBf0JquafYXTdAJwIZpX1xkiphSxj7EVKxXcF1kFUG4opt+3Bw==
X-Received: by 2002:a37:8481:: with SMTP id g123mr9304970qkd.181.1556312608015;
        Fri, 26 Apr 2019 14:03:28 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id p1sm3072425qkb.43.2019.04.26.14.03.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Apr 2019 14:03:27 -0700 (PDT)
Date:   Fri, 26 Apr 2019 14:03:23 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Alban Crequy <alban.crequy@gmail.com>
Cc:     john.fastabend@gmail.com, ast@kernel.org, daniel@iogearbox.net,
        bpf@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, alban@kinvolk.io, iago@kinvolk.io
Subject: Re: [PATCH bpf-next v3 1/4] bpf: sock ops: add netns ino and dev in
 bpf context
Message-ID: <20190426140323.4edf1127@cakuba.netronome.com>
In-Reply-To: <20190426154848.23490-1-alban@kinvolk.io>
References: <20190426154848.23490-1-alban@kinvolk.io>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Apr 2019 17:48:45 +0200, Alban Crequy wrote:
> In the unlikely case where network namespaces are not compiled in
> (CONFIG_NET_NS=n), the verifier will not allow access to ->netns_*.

Naive question - why return an error?  init_net should always be there,
no?
