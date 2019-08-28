Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CA87C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 04:17:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CB9F21883
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 04:17:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="uklzTnO6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726213AbfH1ERy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 00:17:54 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:43486 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbfH1ERx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 00:17:53 -0400
Received: by mail-pl1-f193.google.com with SMTP id 4so572692pld.10
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 21:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=Niv5l9HH8oX8cmDQomRM75jsIj7Etn+DSuDl0AseyHk=;
        b=uklzTnO6sj9quZIsyajLN4YQZpLDswyJW0qoWczLiRt1E9MByAA+d4sw9320j1gmQ1
         lQ/HuM4Tu70nVTMXRcLfVXXXU5lnmQ1XOg2W8SZ/e7Sj7LGHo/aTw0teGImZ5LX31ND7
         6glsFSfw8+I1faq2Jw60Mb/BCza64SY7bu3rmX3SFNhTphlIVU6fMrf+3n177wBWEj9c
         A6w0k7wST+9kiG4g7CGaGS0NBvBV9RIwSdbikUdpMorZ60AV1jr15Sa7doMqLCiq81Xy
         gY/h8DscCe/rvA1evjYSbaW90bqwOG/P7nl/mrsun/Pw5Ir2y4n7+I5YdjY/BMTxQJW8
         4FWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=Niv5l9HH8oX8cmDQomRM75jsIj7Etn+DSuDl0AseyHk=;
        b=We+YmluEOhPlhh/lN0+ufijJGnpJ54zTMYgWwJXbcuvu5tOLlajW4Ip2/pIMZxq8Px
         ElsUFU3nFyqRhe8jYFq/+6hliizVaYJmNAfpXWrz5HOYjNgvXf9Zd+NUjZyBOy/BXfz5
         FVunWOjqmCDerQ4Ylq1XS308ERspeu1hlBjfnAF1SCHMa2LHRU+18I7bjdvcCYVbEeLI
         tM0xYcK3TSh+5otpbGpZXJEyeL2JZ+89z/6TAAq2+6sKi2LzqpNLYeAluPifh9GnOXvV
         xxO+KsivSZTOHewV+bGyr/0qcRrY6seUtlBEoRzJE5PIe5SwH4AisxZrmIip55Pl6R8P
         P6+w==
X-Gm-Message-State: APjAAAXERXqXIUPox72l06S3S9x9MxuUANfjxN6YcKuTcoP3yIoG+Ktq
        BaPHfKSRCLOcSm86nJ0UZKIeUw==
X-Google-Smtp-Source: APXvYqyksML7Z0z2EcU8JugTQamrHOZXVC/fjmpO5hKBEUBs92O6Ek8OPCS5NK3YvrIzBmwogLxnTg==
X-Received: by 2002:a17:902:b605:: with SMTP id b5mr2345725pls.103.1566965873284;
        Tue, 27 Aug 2019 21:17:53 -0700 (PDT)
Received: from cakuba.netronome.com (c-71-204-185-212.hsd1.ca.comcast.net. [71.204.185.212])
        by smtp.gmail.com with ESMTPSA id y14sm1121054pfq.85.2019.08.27.21.17.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2019 21:17:53 -0700 (PDT)
Date:   Tue, 27 Aug 2019 21:17:35 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Hayes Wang <hayeswang@realtek.com>
Cc:     <netdev@vger.kernel.org>, <nic_swsd@realtek.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net v3 0/2] r8152: fix side effect
Message-ID: <20190827211735.269764fb@cakuba.netronome.com>
In-Reply-To: <1394712342-15778-320-Taiwan-albertk@realtek.com>
References: <1394712342-15778-314-Taiwan-albertk@realtek.com>
        <1394712342-15778-320-Taiwan-albertk@realtek.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Aug 2019 09:51:40 +0800, Hayes Wang wrote:
> v3:
> Update the commit message for patch #1.
> 
> v2:
> Replace patch #2 with "r8152: remove calling netif_napi_del".
> 
> v1:
> The commit 0ee1f4734967 ("r8152: napi hangup fix after disconnect")
> add a check to avoid using napi_disable after netif_napi_del. However,
> the commit ffa9fec30ca0 ("r8152: set RTL8152_UNPLUG only for real
> disconnection") let the check useless.
> 
> Therefore, I revert commit 0ee1f4734967 ("r8152: napi hangup fix
> after disconnect") first, and add another patch to fix it.

LGTM, seems like if we were to add a Fixes tag it'd point to the

ffa9fec30ca0 ("r8152: set RTL8152_UNPLUG only for real disconnection")

commit, then? So only net needs it, v5.2 is fine.
