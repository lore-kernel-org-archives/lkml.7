Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF51AC33C9E
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 12:14:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF1E1206DB
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 12:14:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="djw5ZjFv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727659AbgAHMOc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 07:14:32 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:37516 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727316AbgAHMOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 07:14:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578485671;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2PSTrkEUmEq8yVtCMe4CZo86wKH2aSQYOOHALIiDO9Q=;
        b=djw5ZjFvWUJHTCyAdc9awIOSe28vg4k3UFYfkZEBTsZW+FgvX61YgjjaGLIgLx1tvQxAZA
        9BjPGUV/wC9ePP2RLPX83h4zkjJXwrnnbkWq8xfTPBwGZP5rDKLJe78+vLcQMTzkJ+1vzF
        Vc5CaUJ+7Xg9nMVeGnLcyYPAtEWLX7A=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-247-mGUJbaabOruNAO9urvyYWA-1; Wed, 08 Jan 2020 07:14:30 -0500
X-MC-Unique: mGUJbaabOruNAO9urvyYWA-1
Received: by mail-wm1-f69.google.com with SMTP id w205so769262wmb.5
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jan 2020 04:14:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2PSTrkEUmEq8yVtCMe4CZo86wKH2aSQYOOHALIiDO9Q=;
        b=Re9FC3qs1+BqFrL9N5BCTXYZmnRbCGHvE48b+qO2rZw5aRPOeuAWTXMBYFw0IL5hJN
         D0VGGXqZNKTeT6NGANz4xm2z38fbaRXSGFZ6Pq3cpf3lfv7YdNHZO7Mi6b39mmqUtYDy
         BNboENJcddDA4f42XaSn0EZd2EGEQPP20morN1j0f1BQFCMqkA34Jk9dEAeSXjkk68UN
         q5DFZwUY27gtKRYQMmynKMq+woDLa6WZiFdN8q5ZMhcAfYiQFSu1PKSYCVGY1l0BIlNe
         HZmNRFyriQAG81bgp/gZzexsx/25ZRH7wc1Dw6JJIzlet3tv+/PMQsJhE0K5+bjxMDfw
         qv8w==
X-Gm-Message-State: APjAAAXETtrTc5ljwwvkZ0P+USwGGXMwILiqhvZyihlW7jD+cukE/i4E
        dmgivkrzDTat+rC36lPKO9V6wwThEcJq9JZ2Y6DD8aXkrsVzHrOIGoqp7G3mvBy8DnY3NgJaWMk
        oB3Bp+kOD/BM4H5As14O5yVh5
X-Received: by 2002:adf:f2c1:: with SMTP id d1mr4095624wrp.111.1578485669010;
        Wed, 08 Jan 2020 04:14:29 -0800 (PST)
X-Google-Smtp-Source: APXvYqwLGE/Zayzc49T6bqeK61OFosdnZKZRkB2vBFrvaZfvZhQaNJMurCIIG/d6QNkxUTpCIohnfQ==
X-Received: by 2002:adf:f2c1:: with SMTP id d1mr4095601wrp.111.1578485668742;
        Wed, 08 Jan 2020 04:14:28 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c6d:4079:b74c:e329? ([2001:b07:6468:f312:c6d:4079:b74c:e329])
        by smtp.gmail.com with ESMTPSA id f207sm4000109wme.9.2020.01.08.04.14.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jan 2020 04:14:27 -0800 (PST)
Subject: Re: [External] Re: discuss about pvpanic
To:     zhenwei pi <pizhenwei@bytedance.com>,
        Michal Privoznik <mprivozn@redhat.com>
Cc:     "yelu@bytedance.com" <yelu@bytedance.com>,
        Greg KH <gregkh@linuxfoundation.org>, qemu-devel@nongnu.org,
        linux-kernel@vger.kernel.org,
        "libvir-list@redhat.com" <libvir-list@redhat.com>
References: <2feff896-21fe-2bbe-6f68-9edfb476a110@bytedance.com>
 <dd8e46c4-eac4-046a-82ec-7ae17df75035@redhat.com>
 <d0c57f84-a25c-9984-560b-2419807444e1@redhat.com>
 <05c5fcc0-24bd-ae6e-6bb8-23970ab0b56c@redhat.com>
 <d915c9e6-1ad7-4f8f-a66a-c418d43e977f@bytedance.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <2b4b61b0-a586-83e7-dea8-a4942da32024@redhat.com>
Date:   Wed, 8 Jan 2020 13:14:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <d915c9e6-1ad7-4f8f-a66a-c418d43e977f@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/01/20 11:33, zhenwei pi wrote:
> In previous patch(https://lkml.org/lkml/2019/12/14/265), I defined a new bit (bit 1)
> PVPANIC_CRASH_LOADED for guest crash loaded event. And suggested by KH Greg, I moved
> the bit definition to an uapi header file.
> Then QEMU could include the header file from linux header and handle the new event.

Sure; QEMU has already got a mechanism to import files from Linux
(scripts/update-linux-headers.sh).

Paolo

