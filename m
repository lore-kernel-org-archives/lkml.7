Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBD15C282DC
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 19:30:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96B7B20879
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 19:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558553419;
	bh=oz+V7tcmo8AGoh4136gOSbIwMJrzNzom0l6EV8LkA4k=;
	h=Date:From:To:Subject:List-ID:From;
	b=l/tUH/6dl7TlZ73hSalxGVTf3axoqiTElmV1OiBWzbwAjJGd7WSh5Sbuyb0kQ6+rV
	 Boh/0uFZddW9hFa8kWzJ37tur73ZEE4Uin6gMsW1JOwgM1HLW5sitGnmGcuNX3XyZZ
	 ahB3u8tvjuh3aHfrBukCrm+ye6WWROuDGOmwGMI0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732740AbfEVTaS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 15:30:18 -0400
Received: from mail-qt1-f175.google.com ([209.85.160.175]:32931 "EHLO
        mail-qt1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733185AbfEVTaP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 15:30:15 -0400
Received: by mail-qt1-f175.google.com with SMTP id m32so3870465qtf.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2019 12:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=XXMtmfD06zcDwQx0hvcfJIux8aKRhVdW16i73453GEM=;
        b=ELELxw7VjTwqNjvY99Fi8KemSTL6yTDX2IVCt6P/+ATzrcEsJyK42hxgn/Y+ckigru
         YH0ydn+bot1cCzh3kqvCecM44RyL0cYkncX7YuaaRgiecpU2HvzBMZV9vmVs4nhXIaCx
         8qqPRtILZRspj5B6KumSwHJH2qV80l395Ws5o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=XXMtmfD06zcDwQx0hvcfJIux8aKRhVdW16i73453GEM=;
        b=GW3wQhupcWV1Sh1HsbIIp4IaQIfFPHLB0xH3OXhv3HAo55rrwb86J2gghH/QZM5VS2
         arlsA20ruuggWEp50Ijprur0V17DDP7+HdRYMhe5XgYyKk0KpuWY3l+43qJBe8olx/jp
         RDPU9x36U+Hlk4pGPZDeES4YmT7WJoTKWnKaG82C27IE5zFW6eqaT7MMncK6O4WUE2Vs
         Ky31wXxEv3up7ZycCgSfEmOrpappQE9Iv4MHmHcXEE0SglG6cUbECOWkt4zW7DGrWLnk
         AJts5d1YgVJJOA5J9Eb1nP6MTUYLeyjVi4Yj+MseTy8kf4IFN36buNiSIvpVluPXSA/e
         NrRw==
X-Gm-Message-State: APjAAAUmMPSNLj7F7n7QR4z/O1EOyRIn4VA8vULPYCjpDfsg5GxH3ODf
        jX4z0UyIJL3Gn//2ahdX4fV5toi4cCu+Pg==
X-Google-Smtp-Source: APXvYqy0LcxyTKzrA7fqyviU2+zlg0lfX+n6mqhBPOkMDXwp7Mr7KYwA7k/OZixZxbRYh6T9e2XKqg==
X-Received: by 2002:a0c:d909:: with SMTP id p9mr60283913qvj.42.1558553413979;
        Wed, 22 May 2019 12:30:13 -0700 (PDT)
Received: from chatter.i7.local (192-0-228-88.cpe.teksavvy.com. [192.0.228.88])
        by smtp.gmail.com with ESMTPSA id j29sm11466999qki.39.2019.05.22.12.30.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 22 May 2019 12:30:13 -0700 (PDT)
Date:   Wed, 22 May 2019 15:30:11 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Subject: PSA: Do not use "Reported-By" without reporter's approval
Message-ID: <20190522193011.GB21412@chatter.i7.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, all:

It is common courtesy to include this tagline when submitting patches: 

Reported-By: J. Doe <jdoe@example.com>

Please ask the reporter's permission before doing so (even if they'd 
submitted a public bugzilla report or sent a report to the mailing 
list). They need to understand and agree that:

- their name and email address will become a permanent, non-excisable 
  part of the Linux Kernel git history
- their name and email address will be stored on multiple public 
  archival copies of the linux kernel mailing list, collected and 
  managed by different legal entities

With or without GDPR laws, this is something the reporter needs to be 
aware of and they need to be okay with it, as a matter of courtesy.

-K
