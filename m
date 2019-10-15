Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA254ECE59D
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 21:28:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8908820872
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 21:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571174930;
	bh=sGpeywh7e+P+IEFMsT0G9KxpGcEbhwxy1VzFXrDcUgg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Cd7pA1/jn639U2VZ2RWsKAxc6ofk/QEvCsNENpBuctbNi/Cr9Gxvy/JcNoxIGVuMf
	 2SAM9xHcFgw4hvNmZfyqFJJmeRY4h/g0955+nRTWLN5DMDv4uZ3pJ1gEydurxZUoFJ
	 vbnzLExtmuk8jLPGO4rzj04TIr6FGFZckJXZQfIA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729614AbfJOV2t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 17:28:49 -0400
Received: from mail-qk1-f180.google.com ([209.85.222.180]:37447 "EHLO
        mail-qk1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725871AbfJOV2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 17:28:48 -0400
Received: by mail-qk1-f180.google.com with SMTP id u184so20717298qkd.4
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2019 14:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=htrbR6o8gAhuhvFSMF1j4MxspvIfkODTwf86InW+tn8=;
        b=N6F7XlGd9Dquj7OujB5fmKpI7QNw0zkMUi5Be/ImyhzMg9mAYAaMTLJ0tegInU9SrL
         umutYdV2GOiUuFQ4e1putKFvVja63BhBUGDbDRDHDvJX+wVl97tHSt6Ia0t8gfufE+Hd
         UnLBVjF51wVf8XHGiF6qBr+I1Ph40kGdZx51w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=htrbR6o8gAhuhvFSMF1j4MxspvIfkODTwf86InW+tn8=;
        b=n1/651acVPiF1OICx7ZfggI+/C68jhQ8g+wTNsH2Conh2dOrTcy0OXV7f8qIYVRYWn
         ENY1U8gVdeAF5/2WQ4vx4Mtn4PiP+RhKOusgbW01HEcDVXPOJ8Xc+ERDBGpY07ic72dd
         o4DPOX10EIR47lkpZKv9na/EF+2kvDMHvTPMxenaKaAJPzYZ2hL/6+gi6rAnn22IgE71
         HW1oUBuEUfjJ8kmfV+RVJr7aFRq3NZ88XwF6nNNCqlJuX6ZykcpUP1qeb1YUVzlbyktk
         J+J+cGPzcDW6RBEUlREhQ39h/N0V5m5D0OrxPQggsgv0pTvQFqQRWSkzFyi6eEbilqXm
         vAuA==
X-Gm-Message-State: APjAAAWHLmEXe8i1aaQEJ5Xgz5WvHk/AmlXuk3jGXsoYG+CiNJB1m6vA
        SZuC3TrShzjUcBV0pz9iInbr6Q==
X-Google-Smtp-Source: APXvYqwlFJsQgnfn0JEjhrI8269AOdPLREEOeY0b3b29fXyGti1CvWXqU4r1HHz7kwuyOW1lcPhLtw==
X-Received: by 2002:a05:620a:13d9:: with SMTP id g25mr37766987qkl.230.1571174927397;
        Tue, 15 Oct 2019 14:28:47 -0700 (PDT)
Received: from chatter.i7.local (192-0-228-88.cpe.teksavvy.com. [192.0.228.88])
        by smtp.gmail.com with ESMTPSA id y4sm10420091qkl.107.2019.10.15.14.28.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2019 14:28:46 -0700 (PDT)
Date:   Tue, 15 Oct 2019 17:28:45 -0400
From:   Konstantin Ryabitsev <mricon@kernel.org>
To:     Hillf Danton <hdanton@sina.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: problem of posting patch to lkml
Message-ID: <20191015212845.GB14855@chatter.i7.local>
References: <20191012044528.4680-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20191012044528.4680-1-hdanton@sina.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 12, 2019 at 12:45:28PM +0800, Hillf Danton wrote:
>
>Hey Konstantin
>
>The patches I sent out could not reach xyz@vger.kernel.org because I am
>not able to find any of them at lore.kernel.org/lkml unless it was
>replied by the readers. xyz can be pci, netdev and linux-kernel for
>instance.
>
>Tippoint to what to do for solving the problem please.

Looks like they are not passing vger.kernel.org, so I suggest you email 
postmaster@vger.kernel.org. Unfortunately, I cannot help you any further 
than this, since we don't have any access or insight into what happens 
at vger.

Best,
-K
