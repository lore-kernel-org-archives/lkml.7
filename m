Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EBADCA9EB9
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 19:56:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E149A21A4A
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 19:56:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="qx44oaOb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389178AbfJVT4w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 15:56:52 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:38381 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388843AbfJVT4u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 15:56:50 -0400
Received: by mail-lj1-f193.google.com with SMTP id q78so3387998lje.5
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2019 12:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=mJFn/3QyJLqAcJcgayRN2NV4RnnfMUx/ZNp60iWEx0U=;
        b=qx44oaObOl5Z3A8Im8+pd3RJwQ67FnX72mNIzR2fNuacOOqtifUryGU1mSP9cx9Coi
         OwlA4xg5cu62BzgCmrFo5BHDbaaGce4VYz17waemIbXYi5mvl63eMCn1dgsguehVvGzz
         8FWw+rCapfcw470Q3OkxUgJLJZ6281Y5WYQ6xjxRMPHeGeaydHSo6q7bC0Fj1D8IBmrE
         C5VNjCF6+ZzPXerBYfKuZu0o13OdANRZGkEtC+iORESw+cDO+e2pK9sGFqBhY5qe0J9A
         okyPozGjA72PYNCGJSJqa99xICbZJZ2SAXpl+lLoT24JPrzHoUY1HUpwK4rdzQ0aRSwp
         CHPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=mJFn/3QyJLqAcJcgayRN2NV4RnnfMUx/ZNp60iWEx0U=;
        b=S6t5G7PQnUKYZ0ZqVbFP/338MdNp797BtIRdq9O0M9Soufbyh7MYftb/Qk68rqFasV
         lvrf90nHPVnyJLQRymFmQ29xkBniVX0vmLvbOa+EUONzTkv4imncALsX9KeVY0+EHkyf
         10SuvfC4EIDATX0KyncQPL/l/G9meir1Via1OjqJtMNxlD9w6Zs/wWFatvbSkeca1ln5
         EplRjZTULGgqj29sKNoLqx2pSSKGcErAH9Aqnul4TDhTwmZI1aVEfQ0a2JAtuqeaPFb/
         u6Gq48d3fWahNNpDVZ5XySI2RG47WlkMPV7Lp9dk4JGmumcSU6I7MvZ5s6U/jn/K5ytz
         BIew==
X-Gm-Message-State: APjAAAVjLxfoI1KXZ959z3LsmyVgjRewoEfk291TFaIq8rey3yad9dyO
        xz23mbjFEwlH1r2jPmqTiP5R7g==
X-Google-Smtp-Source: APXvYqxV+52xwMMCtGYUGGGLHmIa0mfaTIVpi2sWRWwgXWVGuY7Yc9SOZf2U7O6CBUohPQt+DgwJWw==
X-Received: by 2002:a05:651c:1023:: with SMTP id w3mr3672555ljm.79.1571774208276;
        Tue, 22 Oct 2019 12:56:48 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id p22sm9942111ljp.69.2019.10.22.12.56.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2019 12:56:48 -0700 (PDT)
Date:   Tue, 22 Oct 2019 12:56:40 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Shannon Nelson <snelson@pensando.io>,
        Pensando Drivers <drivers@pensando.io>,
        "David S. Miller" <davem@davemloft.net>,
        Jason Baron <jbaron@akamai.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dynamic_debug: provide dynamic_hex_dump stub
Message-ID: <20191022125640.02f02424@cakuba.netronome.com>
In-Reply-To: <20190918195607.2080036-1-arnd@arndb.de>
References: <20190918195607.2080036-1-arnd@arndb.de>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Sep 2019 21:55:11 +0200, Arnd Bergmann wrote:
> The ionic driver started using dymamic_hex_dump(), but
> that is not always defined:
> 
> drivers/net/ethernet/pensando/ionic/ionic_main.c:229:2: error: implicit declaration of function 'dynamic_hex_dump' [-Werror,-Wimplicit-function-declaration]
> 
> Add a dummy implementation to use when CONFIG_DYNAMIC_DEBUG
> is disabled, printing nothing.
> 
> Fixes: 938962d55229 ("ionic: Add adminq action")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Patch applied to net/master, thanks!
