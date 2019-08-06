Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA0DBC433FF
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 19:40:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B44D20880
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 19:40:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="I5CqAKAJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726145AbfHFTkp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 15:40:45 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:36183 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725798AbfHFTkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 15:40:45 -0400
Received: by mail-qt1-f195.google.com with SMTP id z4so85879649qtc.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2019 12:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=Y7UpGezK0Ud1sFcHnTxPRnpHSsAKoECEyD/JfXJH5eE=;
        b=I5CqAKAJvqBMZ7cVCkQIZzJxWZqDXUmJ4fuZDVxnWO0sObj/kWqJbEiCN/DzeHzivD
         8qIms80lB/zz/ShDMd1VDvdRN5EHjP6LkKuODP2W1iTPeIp7KvpeOh3En1pcYoAc3Skb
         b/zSpO5QpmAhh+C24sIQTl8wTjGjmmr2hy0pKlto1ERsY3Q+W6NriEtj+HuB9Y6nMnW7
         JqSd1u8UcvNaomN3QglbfI8msemVHGvNViZ3+xfWbF5a4Qdup9cHeqGz4eEbTGK4PHmu
         4XeeL8psXWyoNs2BhXqpxpv7h2YNndQJsFnQrVsxQfthViC+T/3V6S83+MCSBw1y3pgZ
         1J6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=Y7UpGezK0Ud1sFcHnTxPRnpHSsAKoECEyD/JfXJH5eE=;
        b=XEdSapeLh1tJJpDmXTyEjyTTDS2yX21ao2eJ+LmggyYzzRCfEGmrkcRS4lUd3N2L66
         //I586DO/jxW9BqDPfwjra587RlZqdpq2CT4KhGxBLJgNfpaN+tH9KUWk51GL3R+PyQh
         Q/ZC4hU7cbMs3dc0EOiVDOg0ZJje0rPUfV+0mPALdPXq5ke6T3VKpapifaMTNG2mxtIs
         0V1mOMjROfRU3y26STl9JvvzNy53jG4SBAelrk/I1XgQkr7V7+p4taUdQPJKolC+YjIb
         dkGR8H7CJOS8vqGM/AXzRlbG0J9G3CoDEI3Qzpq4Jx4yJD54TcRC9oJQ5uIMhoydgUnt
         GonA==
X-Gm-Message-State: APjAAAXnHqeu+ggBgPKcWZn0dCwfYV9bAnDmVnfAhqyhAVBOLyG49it4
        EisUf+wdhsgcobTBQjF+QZ69WQ==
X-Google-Smtp-Source: APXvYqxi59nkItJAOGN4OwKGOH4912Tt8J12kJYya2XOtlNL8EkJaIagn0XHoE9jbWY9aKFh4K3utQ==
X-Received: by 2002:aed:3091:: with SMTP id 17mr1193900qtf.290.1565120444179;
        Tue, 06 Aug 2019 12:40:44 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id y9sm37534001qki.116.2019.08.06.12.40.42
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 06 Aug 2019 12:40:43 -0700 (PDT)
Date:   Tue, 6 Aug 2019 12:40:17 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Jose Abreu <Jose.Abreu@synopsys.com>
Cc:     netdev@vger.kernel.org, Joao Pinto <Joao.Pinto@synopsys.com>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        "David S. Miller" <davem@davemloft.net>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 00/10] net: stmmac: Improvements for -next
Message-ID: <20190806124017.77e0f63c@cakuba.netronome.com>
In-Reply-To: <cover.1565098881.git.joabreu@synopsys.com>
References: <cover.1565098881.git.joabreu@synopsys.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  6 Aug 2019 15:42:41 +0200, Jose Abreu wrote:
> Couple of improvements for -next tree. More info in commit logs.

Code looks good to me now, thanks!
