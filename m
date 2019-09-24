Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1164DC432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 20:43:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D31172146E
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 20:43:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FfRbnqSq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732269AbfIXUnj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 16:43:39 -0400
Received: from mail-io1-f49.google.com ([209.85.166.49]:32851 "EHLO
        mail-io1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726236AbfIXUni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 16:43:38 -0400
Received: by mail-io1-f49.google.com with SMTP id z19so7904153ior.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2019 13:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KVXKu9VmIFP0uRpEeQz97mr1n9TTAsfi4WYGPPOq3/4=;
        b=FfRbnqSqGmaCDq0DjGh5pfroEaEM49w5wIrOLXpIgc7LuSuYFoV5u1KuWNs56elbWf
         lL7nKEhJHyz1HQkQ2npxg+CZdouKSMIcBUAuhCHKr1iA7Thdl0nffusjXyg+iJMbBjFg
         is85uyrw+7ZZfhIeTCrN+jdWpBDEi5faBdgPs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KVXKu9VmIFP0uRpEeQz97mr1n9TTAsfi4WYGPPOq3/4=;
        b=nUfUu0FkXqFNz1uZAkiT3w1inNIfKaxqkQTSOGea8/BAZpCCQtPEQWFSDeYVUwUXLR
         c5X8wThTLxQ4igXO1+l5udu99Qdep1T9y8ir/1/jOA5ZRBur5mXVfCx8ufPUYsSj9NqS
         LHxywPGYdo8bi028WEmd58NBvyxKoBGMdmDCpwqTz4CV6cFcQeQSQX/6OmxwqtZb8G+k
         h7tA/Kcc7w4kdviHZ0OmFxH5DNIHrLp1uI1SKQBcJtrajiIFvhoXkoA6B99fN7cIBMpe
         OqJpEwgdGPEkyiWDXuBnjTtKFuAe07G63tkRDDNSqN5t18XAx0atdT/DNlGpAe6LhWte
         +bLQ==
X-Gm-Message-State: APjAAAU3fdKXFjuSgk5GFuAe9CpR9uacA01mTmMjBOv0BGEm2ZWQlUkv
        j6Eenz/5M2n2YDJo0iUP4/QmFA==
X-Google-Smtp-Source: APXvYqxE41kRqXjyst7trLv1R9E7r2s4yxk0vdBm3c1JbHt0nNYd+LKECg6XH0INxVoV9oonvez2KQ==
X-Received: by 2002:a02:683:: with SMTP id 125mr920060jav.132.1569357817689;
        Tue, 24 Sep 2019 13:43:37 -0700 (PDT)
Received: from chromium.org ([2620:15c:183:200:798c:e494:921c:d544])
        by smtp.gmail.com with ESMTPSA id q3sm3006268ioi.68.2019.09.24.13.43.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2019 13:43:37 -0700 (PDT)
Date:   Tue, 24 Sep 2019 14:43:35 -0600
From:   Daniel Campello <campello@chromium.org>
To:     Benson Leung <bleung@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Benson Leung <bleung@chromium.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Duncan Laurie <dlaurie@google.com>,
        Nick Crews <ncrews@chromium.org>
Subject: Re: [PATCH v4] platform/chrome: wilco_ec: Add debugfs test_event file
Message-ID: <20190924204335.GA212632@chromium.org>
References: <20190918204316.237342-1-campello@chromium.org>
 <20190924001116.GA73943@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190924001116.GA73943@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks. I sent v5 with the corrections
