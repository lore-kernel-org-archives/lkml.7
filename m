Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97586C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 20:02:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AD25218B8
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 20:02:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="bTR8i8zU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732464AbfGVUCK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 16:02:10 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:36722 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732268AbfGVUCJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 16:02:09 -0400
Received: by mail-io1-f67.google.com with SMTP id o9so76808847iom.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 13:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=7KHxh1QD/oXTDWc3Ol8Je8VksYYJh9G9PLns3mcwbuo=;
        b=bTR8i8zUllpMoZ40e03tB7gNhfdJCmmPPAe3V3S37KemxLp2Pfxvdg6aqvRR3nOCMy
         HJUD6xok/NPrliUcSvpBk5vw9NErK3Sgck4dkOw5uYesjEvb0gHvhsbP2cK1sr4pp5Cz
         oVd9jSLisJxIT7CfnmqtAdZwZDq2f6Swd2q3xGrPkPfYRkIoWaPJ5i28Klj54ARyZFTH
         ciWWyOR6+9PFVmVxngR1A312ewaEpkO9R7ubfD1Y6Ulr6DiDalliFyWtv1Ab1hlVpOWK
         zZCh82ajNKWjL+YqFRpoPFhpfupq2020UWCY+v9nviowDi4pL+x/sHuOQdmywjW+ViEY
         zz2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=7KHxh1QD/oXTDWc3Ol8Je8VksYYJh9G9PLns3mcwbuo=;
        b=I9f0f3wI6uVsJ2pGyIyPqjr31bFW/g7wsd53zpkeZ65QthnGnnYUkx6jlDuYD9fdBB
         n9zc8pYxc4Duf+NMviQWdkiSivEnEWhy/ro/MXPj6kZFA5UFyIm2/6ka7oyIMY0pEShC
         an95Pj7UqBfA5fm2WQJszIh7fpAkLPYFoy+QqFkezZHIrdz73/8I5qCVfA8Wp9FcOnP7
         IrTjkmZNAiXg6dh5YTf8HXjfpi3PFnf2L2t/JAx6fPE+NfQQO0gKurTjBOJOCpWUprs+
         qYY5D9O59YVhf+iO0u0NogIIePRGZWIqDJ6NEbR7OvkDUR0HeTEOmjgipR+mgEnNdmlk
         Wbrg==
X-Gm-Message-State: APjAAAXWzheH0w0xtjjsL6YoTKThqlTmB9AmplsvEkfadUJxFkglOYh0
        3JNTLjbHMwXjeW0HySjeP6ABRg==
X-Google-Smtp-Source: APXvYqxyOswcj7g0LDvyDOV3fbWCFcNrYA4iTJciHHWKaqUGvlZ1qgSVQwNjOcAJl5e0SpvoVdMXaQ==
X-Received: by 2002:a02:bca:: with SMTP id 193mr35203345jad.46.1563825729108;
        Mon, 22 Jul 2019 13:02:09 -0700 (PDT)
Received: from localhost (67-0-62-24.albq.qwest.net. [67.0.62.24])
        by smtp.gmail.com with ESMTPSA id b8sm33365705ioj.16.2019.07.22.13.02.08
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 22 Jul 2019 13:02:08 -0700 (PDT)
Date:   Mon, 22 Jul 2019 13:02:07 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Yash Shah <yash.shah@sifive.com>
cc:     davem@davemloft.net, robh+dt@kernel.org, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, mark.rutland@arm.com,
        palmer@sifive.com, aou@eecs.berkeley.edu,
        nicolas.ferre@microchip.com, ynezz@true.cz, sachin.ghadi@sifive.com
Subject: Re: [PATCH 2/3] macb: Update compatibility string for SiFive
 FU540-C000
In-Reply-To: <1563534631-15897-2-git-send-email-yash.shah@sifive.com>
Message-ID: <alpine.DEB.2.21.9999.1907221301490.5793@viisi.sifive.com>
References: <1563534631-15897-1-git-send-email-yash.shah@sifive.com> <1563534631-15897-2-git-send-email-yash.shah@sifive.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Jul 2019, Yash Shah wrote:

> Update the compatibility string for SiFive FU540-C000 as per the new
> string updated in the binding doc.
> Reference: https://lkml.org/lkml/2019/7/17/200
> 
> Signed-off-by: Yash Shah <yash.shah@sifive.com>

Reviewed-by: Paul Walmsley <paul.walmsley@sifive.com>

- Paul
