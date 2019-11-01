Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6274CA9ED0
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 11:09:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EB39217D9
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 11:09:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b="SVs6nDPV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730339AbfKALJ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 07:09:57 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53147 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726720AbfKALJ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 07:09:57 -0400
Received: by mail-wm1-f68.google.com with SMTP id c17so1597030wmk.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2019 04:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=efLeBUV2eVsQE5cLBBJiWMyP67QfoKzAnlUnCU8QlEM=;
        b=SVs6nDPVuDStZNT/dKWBmaT2wt6W/bytIThN5wjiM4TlLJ86P1qYvQG8t/GvSaOs+L
         ZfCoYDcZrWtwa9uaIRuTYDjLfMt/X5edllwC5kGl1rYeYQfVOBUoU3L6QRf0VFZ/2vaW
         yE0H7nyStl6dKxv8bvsx+WLMqu1fRGmbA94UM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=efLeBUV2eVsQE5cLBBJiWMyP67QfoKzAnlUnCU8QlEM=;
        b=fU6W1TcM5BE5tb8RaAtL19l46WSk/W3ZVLptIMGBXqs+1TVGC9/Ra9zwLrW86GJ/tK
         8++Q2JEIChEPNxbVRNlRRbIjblfkU6KcRs8qa6EnpAPN9nT5NZhurC8F1OFQMhRisZ/E
         IP8iQna6UrCRd2sW1x1CZkcWx7n3pz/T9v7AQdmuxai+9xf4MpJ2M13MpTsqfAKagFyI
         5zKuP3BiwSBxVLax6OkCm/xk4NT6J3ULMpstrvxBjUvws1M/Xv+byWIyFr5RjtQT3C78
         8My0QWJ/w1Nr+NBW9tI/baW/qBVSu5FpPIbFtG7YNpxtDSkSnOEzcaDT2n4sPCRVt9vw
         tl7Q==
X-Gm-Message-State: APjAAAUDBOxoaRP0w+W5eREs3LEGm/PCYCeh1XXT74Le/9hN9oPn9Fzx
        Fc1XrjPABpW6LwM1S7lHbHTuTCBzbHqhxC/X
X-Google-Smtp-Source: APXvYqwtz8e2KFotDSkIrc/A9cZrgeg+ndmfC6AnLPShic8k8G6/7xEfIsR7O8flQ/TxCeQ7m6ISqw==
X-Received: by 2002:a1c:2e0f:: with SMTP id u15mr9756846wmu.47.1572606594770;
        Fri, 01 Nov 2019 04:09:54 -0700 (PDT)
Received: from localhost ([2620:10d:c092:180::1:f970])
        by smtp.gmail.com with ESMTPSA id a23sm6359703wmj.2.2019.11.01.04.09.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2019 04:09:54 -0700 (PDT)
Date:   Fri, 1 Nov 2019 11:09:53 +0000
From:   Chris Down <chris@chrisdown.name>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] kernel: sysctl: make drop_caches write-only
Message-ID: <20191101110953.GC690103@chrisdown.name>
References: <20191031221602.9375-1-hannes@cmpxchg.org>
 <20191031162825.a545a5d4d8567368501769bd@linux-foundation.org>
 <20191101110901.GB690103@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20191101110901.GB690103@chrisdown.name>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Down writes:
>There is evidence that this has already caused confusion[0] for many, 
>judging by the number of views and votes. I think the reward is higher 
>than stated here, since it makes the intent and lack of persistent API 
>in the API clearer, and less likely to cause confusion in future.
>
>0: https://unix.stackexchange.com/q/17936/10762

s/persistent API/persistent state/
