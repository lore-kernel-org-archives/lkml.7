Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C195C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 12:55:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E548320679
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 12:55:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RO8plrW1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728556AbfFXMzI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 08:55:08 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:46782 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727327AbfFXMzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 08:55:08 -0400
Received: by mail-lf1-f65.google.com with SMTP id z15so9901367lfh.13;
        Mon, 24 Jun 2019 05:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WNEPAJU0PKDjx+XnMY/T0wpxzKSr9Cr3EplpOoCn4Mg=;
        b=RO8plrW1jTvcIU9jaiUr7gbc5+mACH0QXHLY3czL8SgaIhkmOlLNLRThMiAUSqB5Ly
         8Z0H2FubYRIdzrxk5ZZKDi0MOMaGgn1Cy6DM5Tz5+bBIcstMxY7a0zn93hYlohOi0cx+
         dRaClftcITthbkuf+GMufHq115LKWsPXfIEUGwLbRij2EgfffrDvbyyJjL0tVAxcFR8E
         ABEkxVK/PMW83c2/h7KNA7UkXGfLNPIwfswHio2wX8A0cwQhFG882iRx/C0v6KbAzR8U
         +MFGbBVbfaGX2wbnqHofSk2s1nDCMO6eNmZ/C42BFo9Ak8BkTwY5yq9hUB6/b/pEabsk
         Tj3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WNEPAJU0PKDjx+XnMY/T0wpxzKSr9Cr3EplpOoCn4Mg=;
        b=TWdgT8Brice8h6AD9YrvEUaF9jrKBFQEYuMTBo4/JmkSQ1CG1ciIE3eyuQPIvTK12U
         I/jDL8Tqc7DqE6zShX/UeEj8w7gvdi01UyIZhuWU1bhPBzUrXiLRv5ESLEMJN0tQCRfD
         uegSYlg1B7WwcosUTj/+V5fVp0hIpKY1ECE8wBop6lh2eGMK+mHpqxY8h6hMY66hY7iF
         AUrHGHQ92qkc/HQ022wY9Z5EM3kD4mJIfgmzI3rOH547W3pbNqmyha/lO810ei3dOmvZ
         IPrdrO8+vMfb8vzFvyqJjMg1r8Na0m1mjW//Wt8Cn2UvKJ9n7xnJBYjA0WPVEBGxujfa
         yyVA==
X-Gm-Message-State: APjAAAULvWzz1ZZXgG2wXZVBUKfY0X6GsKrDwup4xQzJ2MBhnVPsD22G
        1bAY9PuXiuCO84VU0DkaoBurslu8
X-Google-Smtp-Source: APXvYqzSDGrndyCxLDg8GGelDuwS8V7x7tQBjK5jsA9NOeIRgsbr70QnRs0ab8nFHEci1xRTIgnoYA==
X-Received: by 2002:a19:ca0e:: with SMTP id a14mr20824806lfg.19.1561380906306;
        Mon, 24 Jun 2019 05:55:06 -0700 (PDT)
Received: from [192.168.2.145] (ppp91-79-162-197.pppoe.mtu-net.ru. [91.79.162.197])
        by smtp.googlemail.com with ESMTPSA id u13sm1568415lfl.61.2019.06.24.05.55.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Jun 2019 05:55:05 -0700 (PDT)
Subject: Re: [PATCH v1 1/3] gpu: host1x: Remove implicit IOMMU backing on
 client's registration
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190623173743.24088-1-digetx@gmail.com>
 <20190624070413.GA23846@infradead.org>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <e7ecff74-ef8e-fd7e-1be2-0f3c60abc6f8@gmail.com>
Date:   Mon, 24 Jun 2019 15:55:04 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190624070413.GA23846@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

24.06.2019 10:04, Christoph Hellwig пишет:
> Don't we have a device tree problem here if there is a domain covering
> them?  I though we should only pick up an IOMMU for a given device
> if DT explicitly asked for that?
> 

There is no specific domain that "covering them". The IOMMU domain is allocated
dynamically during of the Tegra DRM's driver initialization (see tegra_drm_load) and
then all of DRM devices are attached to that domain once all of the DRM sub-drivers
are probed successfully. On Tegra SoCs it's up to software (driver) to decide how to
separate hardware devices from each other, in a case of DRM we're putting all the
relevant graphics devices into a single domain. Is it even possible to express IOMMU
domain (not group!) assignments in a device-tree?
