Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59557C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 15:32:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F9D32073F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 15:32:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ReBaqs3k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728516AbfKZPcC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 10:32:02 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:27814 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728479AbfKZPcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 10:32:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574782320;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1B5z3ocoUnAb+PeLyD8I97QacT7fRBDt6WO9TjOiZjQ=;
        b=ReBaqs3k9hxgc//6t9Rd/+3YOKBpjpONidmvm0F83Hy3yFf/j06gelMtiNRh1r5PP08DvP
        i04/8JU45SkVISSVnZlcT7N6B5Neq+GjBnGQII516ir7O+3JVRGYUWApCyrs+wWeigfLUm
        b3gtUfiM8JwYIoC0EeedYBtxlhnq+mA=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-199-s1CmBi2DP1-3BTLketZoqw-1; Tue, 26 Nov 2019 10:31:59 -0500
Received: by mail-pj1-f70.google.com with SMTP id o34so51848pjb.15
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2019 07:31:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=1B5z3ocoUnAb+PeLyD8I97QacT7fRBDt6WO9TjOiZjQ=;
        b=Zj+fHAArpsHzUxrG7PY5sgl+qF/Qg4RoBl1gtKH4WXv3h3Lr5FHaUKHkVuoePSdEg7
         zmjgFyUvOvBzVwDPvqja2rSrlgTYpmtMCcicj+7YvnyNcW0qP+XdszxeQOXE5neU6795
         9TOwsOLhNZ5zSiFKE3/fmXlkWMGM83UM2dWmxbvurNDQJlaQ8O83P67hg7DP/Ct0KwF0
         X1vP7jOLE+XuJk1iE+ZiMbfC4RirJj8/9WLBC3Fy6tkZspyz++1JfUJQA8NLrXIixTne
         BXhNW4oUhhVKgfAz3/wbGJOVz3JiSPqtTzmP54RhnayDZ3QxGw+gsGVl6FQMpeeHaE9e
         8irA==
X-Gm-Message-State: APjAAAXl3fjjNoVg9XNTKw9c4eLywGsECxgGBJKQIdgAVO2eQZ66gKXD
        hC0lL8lTYXsgzv8XqkZGu3AVBO2dDyARCHG5FWWmH1fAXgEltLbZ02/6Q/ylEGwVvxUVWVrvcXH
        eYviWR2w2m2a/x6QFPMJj+982
X-Received: by 2002:a17:90a:3522:: with SMTP id q31mr7781090pjb.18.1574782318075;
        Tue, 26 Nov 2019 07:31:58 -0800 (PST)
X-Google-Smtp-Source: APXvYqxfmv0tx5D0C/j5BQozTzoh1DEGYoaqkhONpxCb2xxJIi2vBrAwOCHCbdTIbW3eUHnO3MyYWQ==
X-Received: by 2002:a17:90a:3522:: with SMTP id q31mr7781055pjb.18.1574782317801;
        Tue, 26 Nov 2019 07:31:57 -0800 (PST)
Received: from trix.remote.csb ([75.142.250.213])
        by smtp.gmail.com with ESMTPSA id 136sm13292798pfb.49.2019.11.26.07.31.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Nov 2019 07:31:57 -0800 (PST)
Subject: Re: [PATCH RT v3] net/xfrm/input: Protect queue with lock
To:     Joerg Vehlow <lkml@jv-coder.de>, linux-kernel@vger.kernel.org,
        bigeasy@linutronix.de
Cc:     Joerg Vehlow <joerg.vehlow@aox-tech.de>
References: <20191126071335.34661-1-lkml@jv-coder.de>
From:   Tom Rix <trix@redhat.com>
Message-ID: <46d5e7ea-011b-a384-ac7a-9ba63bbe9ea5@redhat.com>
Date:   Tue, 26 Nov 2019 07:31:56 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20191126071335.34661-1-lkml@jv-coder.de>
Content-Language: en-US
X-MC-Unique: s1CmBi2DP1-3BTLketZoqw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Why remove the #ifdef CONFIG_PREEMPT.. ?


> +	spin_lock_irqsave(&trans->queue.lock, flags);
>  	skb_queue_splice_init(&trans->queue, &queue);
> +	spin_unlock_irqrestore(&trans->queue.lock, flags);
>  

Fine otherwise.

Tom


