Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77B78C606D1
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 20:28:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33A8E21707
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 20:28:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=eng.ucsd.edu header.i=@eng.ucsd.edu header.b="O9TVM7vP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405002AbfGHU2O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 16:28:14 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:43079 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730311AbfGHU2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 16:28:13 -0400
Received: by mail-lj1-f196.google.com with SMTP id 16so17238046ljv.10
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 13:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eng.ucsd.edu; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aP50fU9jWh1SVwYTLC+Bnr2NJDpeCgQBUG33TJZRv3c=;
        b=O9TVM7vPx877J6GvjeRwcyAevrgRrCuSS8pcoeJlEHDIViI420nOnFbTzd2KdqHImt
         LUIC0flvjlPO8E3m0D1RH+5iydfGexIVXmCQSpk1/gC9ovhgdt1bBeeCH4oKESBwzqeV
         2XeX4oxEZjXCAld8+vGogj5AhlRTWc2sU2VMk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aP50fU9jWh1SVwYTLC+Bnr2NJDpeCgQBUG33TJZRv3c=;
        b=eTJpyhm1ysiauoRxnubVSJjqybIg4XKXD1RmtBWso83yXbX4Q0gAATTjlpwkuo+qlP
         /ZOxxTwPFuG+6awdNVU9idK0SxLqsCExB4AtQeIZNP2IOtXGTvCp9oNpWMB6HhqBf8Zr
         pvlOMl60dqegZdvCXP2SphiU9rbv7MuthmoKIzCq7sI5xaBxy2tn7jXyDcU9vj22X40S
         4b4CsW7PC7zhVSQRsWQUip0SHPcnxBc/TPUnG3Goyq4oh8SKS4pVgpWtPmlGxkuD69bB
         hdTVQjtv1Yx304zoIzehYOAlm7AA6xO2vAGZmz1S85U5d4pYVKbJ6UEvLHnaOv1vrlVD
         YfNg==
X-Gm-Message-State: APjAAAV/Ng75Mqt5tK2Cic9K/kbfKgGVpBV6kvR7bNvc4P9lHlaAexMh
        JRiIdYl92q3roe5BXX3px63rxg==
X-Google-Smtp-Source: APXvYqyqusmub7bifQwEMHiihwOyK5Pb+umaZm2KbS0Q9R3gTIIIHnNVYU0MymObvFosL9+y+wrpiA==
X-Received: by 2002:a2e:b60f:: with SMTP id r15mr9591215ljn.172.1562617691526;
        Mon, 08 Jul 2019 13:28:11 -0700 (PDT)
Received: from luke-XPS-13 (77-255-206-190.adsl.inetia.pl. [77.255.206.190])
        by smtp.gmail.com with ESMTPSA id l11sm2934729lfk.1.2019.07.08.13.28.10
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 08 Jul 2019 13:28:10 -0700 (PDT)
Date:   Mon, 8 Jul 2019 13:28:08 -0700
From:   Luke Nowakowski-Krijger <lnowakow@eng.ucsd.edu>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        pbonzini@redhat.com, rkrcmar@redhat.com, kvm@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] Documentation: virtual: Add toctree hooks
Message-ID: <20190708202808.GA8859@luke-XPS-13>
References: <cover.1562448500.git.lnowakow@eng.ucsd.edu>
 <ef1edb15bd6a6ef87abf4fef7636cd9213450e3c.1562448500.git.lnowakow@eng.ucsd.edu>
 <20190708135404.3eeed68f@lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190708135404.3eeed68f@lwn.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 08, 2019 at 01:54:04PM -0600, Jonathan Corbet wrote:
> On Sat,  6 Jul 2019 14:38:13 -0700
> Luke Nowakowski-Krijger <lnowakow@eng.ucsd.edu> wrote:
> 
 
> At this point in the patch series, the above-mentioned RST files don't
> exist.  So if somebody tries to build the docs here, the build will fail.
> I suspect that it's pretty rare for people to use bisection with docs
> builds, but it's still proper practice to ensure that things work at every
> step in your series.  So the above entries should be added in the patches
> that convert the files.
>

Yes, agreed. It should be at the end of the series. 

> Also, vcpu-requests.txt is never touched in this patch series, which
> suggests that you didn't build the docs even at the end of it.
> 

In the staging tree I was doing work out of I saw a vcpu-requests.rst
file so thought I could add it "while I'm here". 

You're right. I should only add the files I am converting. 

> Thanks,
> 
> jon

Thanks again, 
- Luke
