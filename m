Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBFE1C32771
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 09:18:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A30F20673
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 09:18:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bGnDETQz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729275AbgAIJSD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 04:18:03 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:56082 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729122AbgAIJSC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 04:18:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578561482;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AhaeYA2g23tahw81bCX4+JNhyu6u4RRAwh7IDkx1918=;
        b=bGnDETQzzeZax0eCTDGKnCN0Ta1vUPJN28FTE3ah/o77oHtmA4j1EQmbAKwKABitgfncwh
        voCrtFnPZF87SQnG+WADQxcJuF6gOwkpESHufl++GRoGLh9ThmOG1xt5Rjj3aFKC3PqxRQ
        Vjo+iRJDr7EKLQCkH9BkdtOboFlaCKU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-27-_TT9qMnqO5KMXmmWHK9tcA-1; Thu, 09 Jan 2020 04:18:00 -0500
X-MC-Unique: _TT9qMnqO5KMXmmWHK9tcA-1
Received: by mail-wr1-f71.google.com with SMTP id l20so2643621wrc.13
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 01:18:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AhaeYA2g23tahw81bCX4+JNhyu6u4RRAwh7IDkx1918=;
        b=Yld40TMs0DCwVJsnwiC7rnSIi6aT+idiQ+2gik/NsG5syPBY4/csymQcgMXIybpHcc
         igaJNlt1NZvR/SFFpCzN9LsoRvM6iSSbcA6o3ybzx6DqUqnexJZI2b3TaPHjPoYnyadg
         rC3mfemuF1Sy8m16MC5Hf7pGFYzmo/6K2PZ4T9ZYkHOSt3uvzbUCvVE55sBs8q32oqsp
         N8vkred5Xzio/mKW7C2oU5OhBdxjpEd4YUemGtQ0KCCjV0yF+HX0NbSIcZCWor7ZRN7h
         GTSJQscwiC46FpHR8G5Bg0kJ5duWj3k2HVkYhaCzhShL5NJAhOhClw0kiBh6DJhYhxu5
         xIrQ==
X-Gm-Message-State: APjAAAX1hL83XPH33hyu3NAHhXYHdEFTypwx3vDcEO8oJLGabHk5jgNZ
        f36dOjC8F6SFk3ZtXP3sA7y16/o/ghKyK8KrIqH8VDii8zwqPx8q8Vmn0f8WTAzSlgKLZoUFY2c
        5HJs6/US4QSvUxyO2SlRZ3bDb
X-Received: by 2002:a7b:c750:: with SMTP id w16mr3790727wmk.46.1578561479820;
        Thu, 09 Jan 2020 01:17:59 -0800 (PST)
X-Google-Smtp-Source: APXvYqwO/dp4Cv+K4wJ8IJ78LS47uYQP/OWWxk4SqeWOvUxwR2mRP46F42N3prbiEGm8IMPofT1Feg==
X-Received: by 2002:a7b:c750:: with SMTP id w16mr3790701wmk.46.1578561479621;
        Thu, 09 Jan 2020 01:17:59 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c6d:4079:b74c:e329? ([2001:b07:6468:f312:c6d:4079:b74c:e329])
        by smtp.gmail.com with ESMTPSA id b18sm7575835wru.50.2020.01.09.01.17.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jan 2020 01:17:59 -0800 (PST)
Subject: Re: [PATCH next] KVM: Fix debugfs_simple_attr.cocci warnings
To:     Nicolai Stange <nstange@suse.de>
Cc:     Chen Wandun <chenwandun@huawei.com>, rkrcmar@redhat.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1577151674-67949-1-git-send-email-chenwandun@huawei.com>
 <4f193d99-ee9b-5217-c2f6-3a8a96bf1534@redhat.com> <87h816nsv9.fsf@suse.de>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <5d75e57a-4d04-e6b9-1bbd-a01072bfa6b1@redhat.com>
Date:   Thu, 9 Jan 2020 10:17:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <87h816nsv9.fsf@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/01/20 11:29, Nicolai Stange wrote:
> 
> How about introducing a
>   #define debugfs_create_attr debugfs_create_file_unsafe
> instead to make those
> s/DEFINE_SIMPLE_ATTRIBUTE/DEFINE_DEBUGFS_ATTRIBUTE/
> patches look less scary?

I agree that could be worthwhile.  My main complaint is the "scariness
factor" of the patches that convert DEFINE_SIMPLE_ATTRIBUTE to
DEFINE_DEBUGFS_ATTRIBUTE, and this change would alleviate that problem.

Thanks,

Paolo

