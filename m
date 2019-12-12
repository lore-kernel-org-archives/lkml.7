Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DD90C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 12:36:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6043524658
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 12:36:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="irhT0fJf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729279AbfLLMgB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 07:36:01 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:23939 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729220AbfLLMgA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 07:36:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576154160;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P7KU0yGpqd+gtXQ7PVameYcgn/rvwEa3g3YEzOaHUqM=;
        b=irhT0fJf01PpLYtwUGGjmA2OtMD29eZlM83IKK682OksDD+wNUe+/7ROQveSHsvQZwNN1k
        s4UU7yGoJGa1lfIYBDcC4h1r0VTrW+dIG8cS3+XHKOf/mY5XArZ1NrBOhYKoE/VRZmSGFi
        mqtzpKvyASuCRgQo0tYGHVUyehoHQeA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-291-YmgUOPNGNW-xyuVRTBEiag-1; Thu, 12 Dec 2019 07:35:58 -0500
X-MC-Unique: YmgUOPNGNW-xyuVRTBEiag-1
Received: by mail-wm1-f71.google.com with SMTP id o24so551563wmh.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2019 04:35:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=P7KU0yGpqd+gtXQ7PVameYcgn/rvwEa3g3YEzOaHUqM=;
        b=qXKsNLewd4f72uEXaOOdYJADQl89D82poJHSHj+kg6S2ev422/PpgT895uKJlIRhca
         C5GC1B94n2ioUFvjAA7643LD765cNdnMpQjscYWd8HLjbX6lEGzhq0RCIs+9NW5luWeR
         KHz3PynOsRtYuLKU9TPrifJpobfZGku9VnS8Gh5IZq1a+GHaJvJNu4rZtWa3PzFdDQ2b
         J5nuEdY+0jSZvg6QEvDkn3R+aNZlPm0IHy38BxqII7KZYXbly8frRT1O0f/ZWk38lGhV
         QF7JdgtPUEqZPXaMT3Yxsc/sAfDyhl3rHyndf1p/hN6N8qGMWlivXNI/2j9RlHmb1MnA
         JBYg==
X-Gm-Message-State: APjAAAWIFtCKI7gMgl3ayBaDegvR8UTYUe55JDSVkC9iZeJxq4MXvtcs
        yiNKLeYA6D+aS0Fp8LjDUYfkBVmnn6DKr4fBAaobVBRQWZiOr7fPREZeE65iPYVGp+pZlEUtAWp
        R9rR3UpAX5efkLKCwf2aFemKo
X-Received: by 2002:a5d:44ca:: with SMTP id z10mr6522518wrr.266.1576154157708;
        Thu, 12 Dec 2019 04:35:57 -0800 (PST)
X-Google-Smtp-Source: APXvYqxxxqa0QtuibXmsZ3mhtFZnBl7CO5d4j1nkjzcJUvAG+Y6HI662ZmVrAU5ebtjXiuk4TPaDHQ==
X-Received: by 2002:a5d:44ca:: with SMTP id z10mr6522495wrr.266.1576154157447;
        Thu, 12 Dec 2019 04:35:57 -0800 (PST)
Received: from shalem.localdomain (2001-1c00-0c0c-fe00-7e79-4dac-39d0-9c14.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:7e79:4dac:39d0:9c14])
        by smtp.gmail.com with ESMTPSA id j130sm1105398wmb.18.2019.12.12.04.35.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Dec 2019 04:35:56 -0800 (PST)
Subject: Re: linux-next: Fixes tag needs some work in the drm-fixes tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Dave Airlie <airlied@linux.ie>,
        DRI <dri-devel@lists.freedesktop.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ben Skeggs <bskeggs@redhat.com>
References: <20191212225202.04d0d0e7@canb.auug.org.au>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <2dd7955d-5477-d110-9409-1c42444ac03d@redhat.com>
Date:   Thu, 12 Dec 2019 13:35:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191212225202.04d0d0e7@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 12-12-2019 12:52, Stephen Rothwell wrote:
> Hi all,
> 
> n commit
> 
>    64d17f25dcad ("drm/nouveau: Fix drm-core using atomic code-paths on pre-nv50 hardware")
> 
> Fixes tag
> 
>    Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=1706557
> 
> has these problem(s):
> 
>    - No SHA1 recognised
> 
> I haven't seen a Fixes tag with a bug URL before, they usually reference
> the buggy commit.

Sorry my bad, that should have been a BugLink tag. The patch in question is a bugfix,
but it is sorta hard to pinpoint the cause to a specific commit, this problem was
probably introduced during the conversion of nouveau to support atomic modesetting,
which is quite a while ago and involves lots of patches.

Not sure how to best fix this since fixing would require rewriting history. I hope this
is just something we can live with?

Regards,

Hans

