Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 853B3C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 18:37:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61CFB20B1F
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 18:37:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20150623.gappssmtp.com header.i=@networkplumber-org.20150623.gappssmtp.com header.b="OrHZBkER"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726511AbfFTShP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 14:37:15 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44977 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726328AbfFTShO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 14:37:14 -0400
Received: by mail-pg1-f194.google.com with SMTP id n2so2004223pgp.11
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2019 11:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5s/l0ITYvPky32c4CeJ1RE7LMqmdddmdnmEyaty1EJM=;
        b=OrHZBkERHshvedquCJ9byOzjBT0TgnCiZhTLxTEfgjlTEDWkSZ7xm23SjABY2IV7Z7
         LjPocB8AGYGUUdHub0lz5lCaFc3zI4O9Pjb91wTwdEDIWnm4jqCZrdMNYbE6VUcOg21X
         xR+ch30YLe6NWjWRVf3BuBgQB9GQgDT+BoCz9VmF4MlXGzEhS+JCzFvBvaRbh67UrflN
         rtSy8aWlvd36lTbrlM/2epUswK1yO6E2GkG1zrkLYoDQEabNqXm3J3bCOl/hRxnLDsbQ
         vvN0Vg/f8B4wxfWplrEqSz4wd9o0VEYsCaSvbEV1c8y9DN1LgA8ABi2PGT/cQsHTR9Dw
         njcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5s/l0ITYvPky32c4CeJ1RE7LMqmdddmdnmEyaty1EJM=;
        b=qQGWcl8wNCyhm6VJ2qjDMa2s7Ag46HM619nz5fwa6cqpQmTiU/RZ/s870Kq57aWQ5R
         aIulvsf1rDJx6ZACMgwhsLJpE75D/vKiob5oMMS3gmDYOa/CHidUWF1RI5sN2TKO/+5o
         kFhYBsR5Zno3C0b47Mt+o+Ug5LVdpw13x3W9HHKcIQ9nBb3XERevXy2fA6iMHcN1J/Ie
         BA6cWZUtj/UxQEU0MyyijSuO5oM625tF6+7AO3lvcz0BKEDH3UE++lAJWcsqYKC1zF+C
         pBVBTAG++U3Ee+/prNbNr/gyrNayBmo2yGQTVOiQGHfnV01vWs64pqSOJztozIZiFaxD
         iahA==
X-Gm-Message-State: APjAAAUYakeL59TBFehVBMwncC+pvOfBHpWpYve0z2u6IO6HHSit88iz
        kbHZ4wIKdvtlIalwiJySX+kbag==
X-Google-Smtp-Source: APXvYqy9uXyk4M5pYOIQFJAB76riuo9dsfgvNobIZLhtZVZfQ8ZXqn6fA3MIbw3Om8NFAwMk9dnxlA==
X-Received: by 2002:a63:2249:: with SMTP id t9mr14261464pgm.149.1561055833946;
        Thu, 20 Jun 2019 11:37:13 -0700 (PDT)
Received: from hermes.lan (204-195-22-127.wavecable.com. [204.195.22.127])
        by smtp.gmail.com with ESMTPSA id y22sm386613pgj.38.2019.06.20.11.37.13
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 20 Jun 2019 11:37:13 -0700 (PDT)
Date:   Thu, 20 Jun 2019 11:37:12 -0700
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     Puranjay Mohan <puranjay12@gmail.com>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        Bjorn Helgaas <bjorn@helgaas.com>,
        netdev <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 0/3] net: fddi: skfp: Use PCI generic definitions
 instead of private duplicates
Message-ID: <20190620113712.4630f60f@hermes.lan>
In-Reply-To: <20190620180754.15413-1-puranjay12@gmail.com>
References: <20190620180754.15413-1-puranjay12@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Jun 2019 23:37:51 +0530
Puranjay Mohan <puranjay12@gmail.com> wrote:

> This patch series removes the private duplicates of PCI definitions in
> favour of generic definitions defined in pci_regs.h.
> 
> This driver only uses one of the generic PCI definitons, i.e.
> PCI_REVISION_ID, which is included from pci_regs.h and its private
> version is removed from skfbi.h with all other private defines.
> 
> The skfbi.h defines PCI_REV_ID which is renamed to PCI_REVISION_ID in
> drvfbi.c to make it compatible with the generic define in pci_regs.h.
> 
> Puranjay Mohan (3):
>   net: fddi: skfp: Rename PCI_REV_ID to PCI_REVISION_ID
>   net: fddi: skfp: Include generic PCI definitions
>   net: fddi: skfp: Remove unused private PCI definitions
> 
>  drivers/net/fddi/skfp/drvfbi.c  |   4 +-
>  drivers/net/fddi/skfp/h/skfbi.h | 207 +-------------------------------
>  2 files changed, 3 insertions(+), 208 deletions(-)
> 

Does anyone still have the hardware to test this?
Maybe FDDI should be put out to pasture.
