Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04042C3A5A6
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 16:02:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0879208CB
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 16:02:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567008120;
	bh=/BjP2jdI/9tjBf+IUF/BgPc7+q+H4cAPwHesykrphbw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=PLL9Her8lDuh0gF/g1DqLhBGUzCAR9rpZepok7MElkyYnyEforoaiteZbJXeHPSQ5
	 1xHkBspX60zlV5v9Ic4NWd3bNPO5ZBtt+aSjiJCCAJ95kPuHEp0XAxgRpM1AxjilJe
	 DVzeh0/BBTMYU9eC7Rqp6K1El8hvM7zkj9LPu6/8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726917AbfH1QCA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 12:02:00 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:44144 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726880AbfH1QB7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 12:01:59 -0400
Received: by mail-qt1-f193.google.com with SMTP id 44so53416qtg.11
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2019 09:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=18vFUXwCCyqrHJ/cXDKe740sqCaN0Wzc0p2txngC8Ek=;
        b=P7SsQclItQ7TwVhV0y5ycfjFwdQA0FmKtll48jZxDnHxDPlabGC92g7nP40H8IkSi+
         MMF3E9f16tNAhesicaRbghW6Smmv/5aIoPs4Rz68aaMXUS5332CcDu19gZhvVqy7M0rc
         4g19xczqRq6l2PDdHOOsQSgewSZGLBDBy5X7s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=18vFUXwCCyqrHJ/cXDKe740sqCaN0Wzc0p2txngC8Ek=;
        b=ZaroYaHrMIYHPZAcugea73vpg/LtyrZQsiA4csr/z48HmjaWDdLIBMqP2oUFM8dmZp
         a5H07bj3uhkM0lKnkkUYyXtpddFb8p/fc3TmcxczW37X0zvEQhCpTc3d3HCHdDtFA1sx
         vMky4K1/+c/8Tqw5+94Y4l7iLhYlBB63TpkiPAV5eSqKsIqgP1PH6gRpn5jWpEx2pHux
         tTmdf0o6BwJrfoCOiVs5/Lr3lB3bvRl59hkg9ExbDiw+u+99TzDjEPMaWhEQSZzf3eAS
         givTfMjN1htNdi7+XjMMQfOatdyygMS2nYpti6WunohAkmcNFpQACfbcM2AP2Dv4rWgq
         SEuw==
X-Gm-Message-State: APjAAAUILvAEm8tCq06ej1+9HbOjkzi/0LcMMkwmrQF9OonK21vlx1KA
        pX0IMdAWE4dy1OqUR7CYXct0Zw==
X-Google-Smtp-Source: APXvYqx4jGyz1MuhN9X9a/bicikxi0tdkyCPTLusG+cCbuet+03E0QpqUxM5Jstq4dpXPnj2AYgdgg==
X-Received: by 2002:a05:6214:104f:: with SMTP id l15mr3259215qvr.189.1567008118708;
        Wed, 28 Aug 2019 09:01:58 -0700 (PDT)
Received: from chatter.i7.local (192-0-228-88.cpe.teksavvy.com. [192.0.228.88])
        by smtp.gmail.com with ESMTPSA id l206sm1411936qke.33.2019.08.28.09.01.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2019 09:01:58 -0700 (PDT)
Date:   Wed, 28 Aug 2019 12:01:56 -0400
From:   Konstantin Ryabitsev <mricon@kernel.org>
To:     Greg KH <greg@kroah.com>
Cc:     Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        StableKernel <stable@vger.kernel.org>,
        LinuxKernel <linux-kernel@vger.kernel.org>
Subject: Re: Latest kernel version no NOT reflecting on kernel.org
Message-ID: <20190828160156.GB26001@chatter.i7.local>
References: <20190828135750.GA5841@Gentoo>
 <20190828151353.GA9673@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20190828151353.GA9673@kroah.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 28, 2019 at 05:13:53PM +0200, Greg KH wrote:
>On Wed, Aug 28, 2019 at 07:27:53PM +0530, Bhaskar Chowdhury wrote:
>> Am I the only one, who is not seeing it getting reflected on
>> kernel.org???
>>
>> Well, I have tried it 2 different browsers.....cleared caches several
>> times(heck) .....3 different devices .....and importantly 3 different
>> networks.
>>
>> Wondering!
>
>Adding Konstantin.
>
>I think there's a way to see which cdn mirror you are hitting when you
>ask for "www.kernel.org".  Konstantin, any hints as to see if maybe one
>of the mirrors is out of sync?

Looks like the Singapore mirror was feeling out-of-sorts. It'll start 
feeling better shortly.

-K
