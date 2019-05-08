Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C01B9C46460
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 00:56:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B4AA20675
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 00:56:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PTVy54EL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbfEHA4D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 20:56:03 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:55733 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726276AbfEHA4D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 20:56:03 -0400
Received: by mail-it1-f194.google.com with SMTP id q132so1279339itc.5;
        Tue, 07 May 2019 17:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PiA2GgebXiGNdOioGbkk07AYvlMPPYqr0D+S0vlim3g=;
        b=PTVy54ELFIhLsI8bp1RMULWZyQb5ZZU3fwT8GVCOMiIn48rF8VsnJET3EQhpASGnqo
         1KZcEFLuywYruJsTRL/Mg+7BIoPuGMcXJMpQpgRj8gNRN0y5aYsa2Qp7en62B5rtAO7m
         UjQ/uZeWF1UrMDYhzh0ngUDTvqvL9rrJ/P5ZK3mn8KhImUW42SZUNzvNDU9lL6/lU1nw
         dyF5bBBw7lFOyS1XAkWNe5j43bLlZ0p94xN3FQHveHgWHvlmzE0tUzd7b2i4HQhf+S5e
         qCg/kYlCbn6AjY6S2Hc+bcYciFjUPJATmd+POI362jsBsSkK6P5W1qxuw+tVy73gDFdU
         UT/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PiA2GgebXiGNdOioGbkk07AYvlMPPYqr0D+S0vlim3g=;
        b=baex1q2a3J35/j8cEh24Vk2ZGuEcs5cUvAXlowAnfy72Z5Yb7oJ2ihyW+uezdr1BQW
         w3KhG2MrXlr3e11FWtEJTJUDICVOJRxOLlTFz83pzFSM4ReYF3SXOsiQB1+d7WHPL6yi
         soNMUa2JDxtPZTi35iR+VDF/Ri1eMlHxwDkGx2IzLYkNMDwLofAj5dJp6cFSTsuFam3K
         KOr0rM0jcK/U31EBykqqmDP9CSile/i7m64R5bcwsfq5KTBpW4o4KgTkPDYYvwWBTQ8d
         72CiqLZKUxA7Xmn/QL8OHAlvcH67pYzPDASPAxEgK4WsuewITvtuZ2srexlSe7zOxtfg
         ppfw==
X-Gm-Message-State: APjAAAX9TJj9PHBSMGj+2EDuS8sO/IEruvtP+JPzztMX4jxuDShHToQQ
        iJEIi0MSEIiHmxqbH4XdEak=
X-Google-Smtp-Source: APXvYqyywlxZxShrE23vVOV73uE/g8MoECS3kQY2Ve8zo9PGQ1+e74AISFNwf0PRfF/AqUZWdTReag==
X-Received: by 2002:a24:c3c2:: with SMTP id s185mr1040884itg.156.1557276962433;
        Tue, 07 May 2019 17:56:02 -0700 (PDT)
Received: from asus (c-73-243-191-173.hsd1.co.comcast.net. [73.243.191.173])
        by smtp.gmail.com with ESMTPSA id n138sm358940itb.32.2019.05.07.17.56.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 May 2019 17:56:01 -0700 (PDT)
Date:   Tue, 7 May 2019 18:56:00 -0600
From:   Kelsey Skunberg <skunberg.kelsey@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 5.0 000/122] 5.0.14-stable review
Message-ID: <20190508005558.GA2689@asus>
References: <20190506143054.670334917@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190506143054.670334917@linuxfoundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 06, 2019 at 04:30:58PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.0.14 release.
> There are 122 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed 08 May 2019 02:29:09 PM UTC.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.0.14-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.0.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h


Compiled, booted, and no dmesg regressions on my system. 

-Kelsey 
