Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49661FA372A
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 14:53:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 132962064B
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 14:53:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b="su3KOVPZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406247AbfJQOxY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 10:53:24 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:34043 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731768AbfJQOxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 10:53:23 -0400
Received: by mail-qt1-f195.google.com with SMTP id 3so4025800qta.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 07:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ld/o0qP+SneQQgE+uBoG6GwZVE33B8FuK6qCwWWByfw=;
        b=su3KOVPZA1PilQqalqGvbhhUf0OCcU5AON3yggp2ym7nNBP1izlDeL6FSZPaIlN7Vf
         O7A2hc9Zx8it6XNzwXPlGroJDa56uj/3B/5+QQdl9yu9tX0W8kzFiseppjPIpg6nRJMy
         pO0HXmXrYHW3xPM6VfsQAt2rD2O/NEtGYODmc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ld/o0qP+SneQQgE+uBoG6GwZVE33B8FuK6qCwWWByfw=;
        b=PMUnf1cpgL6xylc7MmwRU3v2Wgmq1rHq1m6ezoZEbghBjNLyNW0Ne7cr2lgqJzBxgH
         ATBsNIeAfwTdzTt1y7WU9yp8AnU0Jfwbq/t7fKjjmket8rVsN0naeDZkYIosIJFB1aal
         o16g2Pig7gRyzUBybmHajMUyzSSiGPUnn1dvzuSfmXmyxXbSizet93vzW1h00I/vHA16
         2/Wj7cw2oVgbCSLdwLfUDAH9gJPXCApHUsVUW1Qm+Mmn0/AsbIOLRRuBkeEeroxmqZH9
         71TfUoePWjvZre/72gHCHZzCdhIOm8iu1dnZRtWAPMm2wBEr8WMimo6NESfG6/opWJR1
         BzKg==
X-Gm-Message-State: APjAAAXAHl0LZb+78xk1jFmIYRb0scFM9T/YDGMdVP2GeH15FkQ5cI/d
        c1wsxSx66DI7Jn8DMCzJ9tvhoQ==
X-Google-Smtp-Source: APXvYqwQTPiYHNjXoIpSbAiP2HRsWVoovfVnXXUX67EzAjUi/I/6sP7yLC70vxwOE+vtOtaU76pBCA==
X-Received: by 2002:ad4:50c2:: with SMTP id e2mr4308777qvq.67.1571324002493;
        Thu, 17 Oct 2019 07:53:22 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::b253])
        by smtp.gmail.com with ESMTPSA id v68sm1274124qkd.109.2019.10.17.07.53.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2019 07:53:22 -0700 (PDT)
Date:   Thu, 17 Oct 2019 10:53:21 -0400
From:   Chris Down <chris@chrisdown.name>
To:     linux-wireless@vger.kernel.org
Cc:     Shahar S Matityahu <shahar.s.matityahu@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iwlwifi: Don't IWL_WARN on FW reconfiguration
Message-ID: <20191017145321.GA1609@chrisdown.name>
References: <20191017144841.GA16393@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20191017144841.GA16393@chrisdown.name>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To be more clear in case this actually is representative of a real problem 
(although I doubt it since this seems present on every device like this I 
encountered), it's always FW_DBG_START_FROM_ALIVE:

    % sudo journalctl _TRANSPORT=kernel -o cat | grep 'FW already configured' | sort | uniq -c
        403 iwlwifi 0000:3a:00.0: FW already configured (0) - re-configuring
