Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC21DCA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 03:36:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E1E52086D
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 03:36:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="wjdFPrS9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387579AbfJVDg3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 23:36:29 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:32970 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387473AbfJVDg3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 23:36:29 -0400
Received: by mail-pf1-f196.google.com with SMTP id c184so227088pfb.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2019 20:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=cVy7yShhC8zq//OaJuW+5FNqcWb0Q3J+anwfZn0q1yg=;
        b=wjdFPrS99Qew3fagBBczM4Wsds99NvhHTvVot1tWpUCWOdm4Hb/cu2O0HCzHA6/Mjm
         Qj0rVanAt/5WVnqIysEkKdBdVyMSeZ5fuXYcWdDeKw1IFAdR5tLLCksEqmk9fI34l504
         dy1oWssBXD6FZJvLY3ed/jixqln22tD36CDBE9JE2Vh0hvY92aGD34wxlralqIMbrEMM
         mdiz1lounw/ppXFAiOdI6MamLDwlo2KhkaaxVryulCVC3qpS4Gw3DrJkXHCKUXpV/fXP
         8AAIeH4blNuEy1Y9AebZDUHfqqdv5ZJrdeppRFHXuU1ue+NpHMpWf69DyguL/PO0gjm/
         nTpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=cVy7yShhC8zq//OaJuW+5FNqcWb0Q3J+anwfZn0q1yg=;
        b=U2O4S325fHQkd8S8gFzxsYy+LKnUPzD0vZKZ+dE+kFaFju4Il+gHJ6amSQy9D5B+0h
         jL07yzfC3DOJlSsUtbPszraXIG4sb+fXLrYGdA+FUlefwD+ROrezub4N1SEzZocd/kv7
         ig0qYtwC7jkhjbSNYYPAleu/FSleXON+NB2VgQXsQNvYWG90O6NS7z3oIJe/duujUHKj
         B5477ht5PChWM8b55Bq/gLbz56jWhFjZG2x/FIuaLiQPLgaEY8pyLClJ+hX7WdiAIwxm
         jmq8A85oSGFotVB4ufvtAWJZULyuQrFrPn3fM4muXDtnZHh8SK7bUS5NnxBgOjkyptyU
         DTEg==
X-Gm-Message-State: APjAAAWR2tCNAGuVPZANj7OuOK7B0FmoIy6nh3b0AKjZ+2Q8DX2mAO43
        EqFlaOmRIu0/krAEtQm1UstgWw==
X-Google-Smtp-Source: APXvYqxYNpB27E8snEB5dKY2A/L9yUso54sLY2ck5r6vDnSmXHGLHYCdPhWQJqD/GKCo12evJQUlHw==
X-Received: by 2002:aa7:838f:: with SMTP id u15mr1671720pfm.74.1571715388539;
        Mon, 21 Oct 2019 20:36:28 -0700 (PDT)
Received: from cakuba.netronome.com (c-73-202-202-92.hsd1.ca.comcast.net. [73.202.202.92])
        by smtp.gmail.com with ESMTPSA id l23sm16094004pjy.12.2019.10.21.20.36.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2019 20:36:28 -0700 (PDT)
Date:   Mon, 21 Oct 2019 20:36:25 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Hayes Wang <hayeswang@realtek.com>
Cc:     <netdev@vger.kernel.org>, <nic_swsd@realtek.com>,
        <linux-kernel@vger.kernel.org>, <pmalani@chromium.org>,
        <grundler@chromium.org>
Subject: Re: [PATCH net-next 4/4] r8152: support firmware of PHY NC for
 RTL8153A
Message-ID: <20191021203625.448da742@cakuba.netronome.com>
In-Reply-To: <1394712342-15778-334-Taiwan-albertk@realtek.com>
References: <1394712342-15778-330-Taiwan-albertk@realtek.com>
        <1394712342-15778-334-Taiwan-albertk@realtek.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Oct 2019 11:41:13 +0800, Hayes Wang wrote:
> Support the firmware of PHY NC which is used to fix the issue found
> for PHY. Currently, only RTL_VER_04, RTL_VER_05, and RTL_VER_06 need
> it.
> 
> The order of loading PHY firmware would be
> 
> 	RTL_FW_PHY_START
> 	RTL_FW_PHY_NC

Perhaps that's obvious to others, but what's NC? :)

> 	RTL_FW_PHY_STOP
> 
> The RTL_FW_PHY_START/RTL_FW_PHY_STOP are used to lock/unlock the PHY,
> and set/clear the patch key from the firmware file.
> 
> Signed-off-by: Hayes Wang <hayeswang@realtek.com>
