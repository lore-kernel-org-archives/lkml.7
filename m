Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A57F2C04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 15:14:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E2A020673
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 15:14:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20150623.gappssmtp.com header.i=@networkplumber-org.20150623.gappssmtp.com header.b="Z7oQGppd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729195AbfFFPOo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 11:14:44 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36395 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729114AbfFFPOo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 11:14:44 -0400
Received: by mail-pf1-f193.google.com with SMTP id u22so1703539pfm.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2019 08:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TzDoPcS3HLhIwNYev308ripJfQS3Yq68GyHRxr8IupE=;
        b=Z7oQGppdBcUoY2AIRTVVIm6fveADrwDEDjYkeWtG92nm3I34Vf+4rBjD0+tShk2JZY
         zMOuPZQJD4xTG2QlCbolIZagYyyUVzbaUYCILkZhbadB9GaVO1i752zqn/Yhf+G+frL1
         +uI2QigmmrKAyivUqjHkOYwbC2ZyJsQlKcfZzGUP20e4DlqZfc6xvAjuevvKtSlC5g2n
         EfOfV81YjH0QtUEr4mPeR6xxqpD/XVCgAUyorl6cUbbwVjJ2zDalNVvNCUY9//8WYi/5
         5RyIiobxFXceSBlfdzlRPRIyQGO8moX1+WSst6+0T32di8yOUdt23bmvA0Z1GhqrOKVM
         yuzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TzDoPcS3HLhIwNYev308ripJfQS3Yq68GyHRxr8IupE=;
        b=g7BvdzzWQJRyFfqCY1ohJHATlBcoaNDfS+LAVtogry8iu94Rd7oTQeqRFqQMrtlO9Z
         +UNQfe4JgcOHExrKF8ASQBtgS0NSBkMilgilqLA5v5J/yU/y+nl/LkWSBzs4B+FpHOd3
         G7rgJMFQxfwWcd8Qh7IOZ22aphGMfcA4m46IloX+MWV/999foGGhNJR5lktZ7TMCmSyS
         HsbJyMtMuEb/2dSP+fgGVgKhWtDFdIbH2HSKCnkQ+6odSSTeRMMwJmecbJkEQLlVUm6e
         9RsubdnNdw5y/SH6uiJT9jE2HbObvO4tgMgAuKuDPAGFv41nXrkNBsMHpMe4qX+pSyE5
         ySuw==
X-Gm-Message-State: APjAAAWYSvunvm1dzu+is883uq/KCqATsX1zC2Qk1OUYozh6cj1rrOxy
        1YzPogVXVXS9HeO5HgczF5rYCg==
X-Google-Smtp-Source: APXvYqwAU02iZVBjbeWMz80sRLCvX9L3gZbYDIG0gOLE00fiif1RiWci65jT5Rrfdm8RsBWklOKgkA==
X-Received: by 2002:a63:1c59:: with SMTP id c25mr3749595pgm.395.1559834083339;
        Thu, 06 Jun 2019 08:14:43 -0700 (PDT)
Received: from hermes.lan (204-195-22-127.wavecable.com. [204.195.22.127])
        by smtp.gmail.com with ESMTPSA id e184sm2407652pfa.169.2019.06.06.08.14.42
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 06 Jun 2019 08:14:42 -0700 (PDT)
Date:   Thu, 6 Jun 2019 08:14:40 -0700
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     Christian Brauner <christian@brauner.io>
Cc:     davem@davemloft.net, netdev@vger.kernel.org,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        bridge@lists.linux-foundation.org, tyhicks@canonical.com,
        pablo@netfilter.org, kadlec@blackhole.kfki.hu, fw@strlen.de,
        roopa@cumulusnetworks.com, nikolay@cumulusnetworks.com,
        linux-kernel@vger.kernel.org, richardrose@google.com,
        vapier@chromium.org, bhthompson@google.com, smbarber@chromium.org,
        joelhockey@chromium.org, ueberall@themenzentrisch.de
Subject: Re: [PATCH RESEND net-next 1/2] br_netfilter: add struct netns_brnf
Message-ID: <20190606081440.61ea1c62@hermes.lan>
In-Reply-To: <20190606114142.15972-2-christian@brauner.io>
References: <20190606114142.15972-1-christian@brauner.io>
        <20190606114142.15972-2-christian@brauner.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  6 Jun 2019 13:41:41 +0200
Christian Brauner <christian@brauner.io> wrote:

> +struct netns_brnf {
> +#ifdef CONFIG_SYSCTL
> +	struct ctl_table_header *ctl_hdr;
> +#endif
> +
> +	/* default value is 1 */
> +	int call_iptables;
> +	int call_ip6tables;
> +	int call_arptables;
> +
> +	/* default value is 0 */
> +	int filter_vlan_tagged;
> +	int filter_pppoe_tagged;
> +	int pass_vlan_indev;
> +};

Do you really need to waste four bytes for each
flag value. If you use a u8 that would work just as well.

Bool would also work but the kernel developers frown on bool
in structures.
