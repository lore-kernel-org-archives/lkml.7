Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC329C4740C
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 09:47:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9210820835
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 09:47:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IXLOA+1T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392687AbfIWJrA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 05:47:00 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38856 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390596AbfIWJrA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 05:47:00 -0400
Received: by mail-wm1-f67.google.com with SMTP id 3so8507425wmi.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2019 02:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5elTXzM6xlr8PjUTcrYvX5g+KiCaroLiG/40wyuwe8s=;
        b=IXLOA+1T4aETvd3O9XWO8iNbUKNrgVGLqUimU+DN5SdqYCrVRZFp8ITqo/SWtvODY0
         do42IgUiw7g5IRxm+5mARa1kr+2mJZ9xHZG5RtJdz3jQy78nhtyO+hhK2LRtxaXt6vAA
         GJSvkFzeWH/nmuHeBbublaFZmxG4xXf7MtqxuhtFTm5rPWEOb0IEx9q5mpsYyQplCcIs
         2Jp5ygJxcv+yaVO2bscDRYdWJYIHUEZJPZEu9SKFIreP4Y5NTUo6GQBQ05dVJkncyigx
         5PuEw/l0x/EC+6GoSsSAU7sLk6gnXsA0W/Hofb6yWadlH/VJOt4hIJbHEixQxjNPsFr1
         FFkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5elTXzM6xlr8PjUTcrYvX5g+KiCaroLiG/40wyuwe8s=;
        b=RPAkSBnX3TL93zX8GTJr9C9ffGEoSdbYwJ2bySrVi06sjCEwmQMuSoQ6VFta6e3cGh
         DYvI+Cp7ifKcN76zC5OVynAbMOYWXXyyXGym4Ho0/PQNFjRKPi+eBKKLPI+KXZjxXGlE
         3Ldm+hLy11nCezYXael7grJWepceQ1yx9SuqUqGvdJpc1v7WLmF4qHZcCq9SvhI5XMZz
         xvyYqerRNiuQwZH0muMkMkJIUZ907O332nSv6vGFMhd/AZtUH8UNLMXOw8CfRjSTPQRv
         RxZ7DlIkXBvOEt+jIiZnWENYXEMtkiKeSFBGOE2kfuZpL1A8Ce3Hwc5//4KHEFmCnVQS
         UOaQ==
X-Gm-Message-State: APjAAAWGeL4N6+v2TKEvV45LW+JvLLmcSKsdboKNDqWs66WL5GLXlcLn
        Csn74R/DnSWiX1aLxn+04vQ13Kj6
X-Google-Smtp-Source: APXvYqy93ietjX1bSVrNtVPwZS+jbfnCafIE+1DjFr1b+2lowlovhD+hOJDzgtxTj7pFEKe6Yu2tnQ==
X-Received: by 2002:a05:600c:241:: with SMTP id 1mr12931695wmj.162.1569232017788;
        Mon, 23 Sep 2019 02:46:57 -0700 (PDT)
Received: from [10.43.17.245] (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id o19sm13347126wro.50.2019.09.23.02.46.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Sep 2019 02:46:57 -0700 (PDT)
Subject: Re: [dm-devel] dm-crypt error when CONFIG_CRYPTO_AUTHENC is disabled
To:     Thibaut Sautereau <thibaut.sautereau@clip-os.org>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com,
        Alasdair Kergon <agk@redhat.com>, linux-kernel@vger.kernel.org
References: <20190920154434.GA923@gandi.net>
 <20190920173707.GA21143@redhat.com>
 <13e25b01-f344-ea1d-8f6c-9d0a60eb1e0f@gmail.com>
 <20190920212746.GA22061@redhat.com> <20190920214758.GA162854@gmail.com>
 <20190923082016.GA913@gandi.net>
From:   Milan Broz <gmazyland@gmail.com>
Openpgp: preference=signencrypt
Message-ID: <f820c3e8-8538-ac95-9303-eeee77c903ee@gmail.com>
Date:   Mon, 23 Sep 2019 11:46:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20190923082016.GA913@gandi.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/09/2019 10:20, Thibaut Sautereau wrote:
> 
> On top of that, there's no hint in kernel logs about a particular
> algorithm, feature or Kconfig option that could be missing. Do we really
> expect people simply tuning their kernel configuration to go and read
> the source code to ensure they are not breaking their system?

AFAIK all standard Linux kernels in distros have these options enabled,
so it works out of the box.

So it is the opposite view - if you are setting your kernel options,
you need to dig much deeper...

I can perhaps add some hint to userspace if this is detectable from errno though.

Milan
