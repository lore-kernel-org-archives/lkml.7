Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E27CC31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 17:14:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61DE22053B
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 17:14:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kNHab+lV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728918AbfFMROe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 13:14:34 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:42352 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728813AbfFLVxk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 17:53:40 -0400
Received: by mail-pl1-f194.google.com with SMTP id go2so7159069plb.9;
        Wed, 12 Jun 2019 14:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sF5eZ8ccOdUVhZ+yD1F3lyg7ISOOzEpkdH3AlG665WA=;
        b=kNHab+lVszS41ajdNq+qQPTlg6l670gPy4qjY7YG4PDulI+oEDbXLzQVBHeFxGn9mv
         yFQyT12V5R1bs4DLxboxj06C7nT1lt7fLqHY3m7lpXB3Stp8ofgPzW7jxxo6WPIUYSXE
         nHFTnrueCbpnXdjGzNt4UiUet71kdmdPxaH+q4tlnhMwwWa9pxOAvISNbvDj8d4aNsZM
         vuqrA95a5NOFFs2yu7st6sybslXEXCn2Ro9Wh/NU432EdQVDx6s7IiRIJygGCPvjKvri
         BM+Zzemp+WasD62TDhLjwfTC3meEWLFSSF3pW7XzU4r6ejPgRvd8lAdk8lZ81a/Ys1C9
         jwag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sF5eZ8ccOdUVhZ+yD1F3lyg7ISOOzEpkdH3AlG665WA=;
        b=aiA6C29CtW5Zr3+TDZ85p8Biow6+b2jBlIjQ75Zc9ox2IskNCQpjYSPoanxDORw8T3
         VgV7IQClURcwvRjLkbgwPbTmaaEW94r7UymjfNgLgCEcp4oWIV3U9Nf2Haxw2u+8QYPp
         vUZTXHWAKunVN1MZRhOYt9d8Fe3HK1xe2sQMffS7H3Jk0oU5tcNP8kNbRcZsCZ+/Kpvi
         MGZTI30EmVnV5ZwNf039Y6lXKPFPJEGkoURm0CceXlw/SywoJmNb+x7uVcsBrEIaYqc6
         WzuClu9/W26KyxUGkJ7+KqlcmRC2cB4BiFU7rTPGrSbCUBgNf4XABkEJTcJRSj+YXEV2
         CmEw==
X-Gm-Message-State: APjAAAVq3Hyueh9jQEXXAtHP9Z6nn9om+kBdAi/vjcWl+weCFMIzHaFU
        /Ad1te8quRrUqvFYRSQ7MlU=
X-Google-Smtp-Source: APXvYqx1BKexrGHOYAGc6B2VvZQHJ0ldV141e7VWln+TRXutB8eaXkUXN+zHGj9EaQgVtp2cWL28FQ==
X-Received: by 2002:a17:902:9682:: with SMTP id n2mr76598713plp.95.1560376419900;
        Wed, 12 Jun 2019 14:53:39 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id 12sm500677pfi.60.2019.06.12.14.53.39
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 12 Jun 2019 14:53:39 -0700 (PDT)
Date:   Wed, 12 Jun 2019 14:53:37 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Sasha Levin <sashal@kernel.org>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers: input: serio: Add a module desription to the
 hyperv_keyboard driver
Message-ID: <20190612215337.GB40779@dtor-ws>
References: <20190530174645.18147-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190530174645.18147-1-sashal@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sasha,

On Thu, May 30, 2019 at 01:46:45PM -0400, Sasha Levin wrote:
> From: Joseph Salisbury <Joseph.Salisbury@microsoft.com>
> 
> This patch only adds a MODULE_DESCRIPTION statement to the driver.
> This change is only cosmetic, so there should be no runtime impact.
> 
> Signed-off-by: Joseph Salisbury <joseph.salisbury@microsoft.com>
> Reviewed-by: Michael Kelley <mikelley@microsoft.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>

This is already in Linus' tree as commit
9d1c2f067e50bebb521ed6ced49ddf53bb1deba8

-- 
Dmitry
