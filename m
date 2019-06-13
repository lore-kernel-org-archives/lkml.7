Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F41FC31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:45:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65A4A215EA
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:45:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="Ls6aBDLI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MKLJMkWt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392834AbfFMQpN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 12:45:13 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:57977 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730379AbfFMGK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 02:10:29 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 7E3BB2099D;
        Thu, 13 Jun 2019 02:10:28 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 13 Jun 2019 02:10:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=/cACM9Ddbiw1D+hTEKwzTopFWpx
        8KO4E+LJszIQsNdc=; b=Ls6aBDLI1AmVMF60LseXTW+24p0XqbmMFOMQelPOwS3
        /uiGop6DYdFW2Jkt6y1ZnphCXBicbcgYgNkuZSWm9emPWEE6Wad0nuymzJPNdDJ4
        LjctQLXYLXEmVRWeDKN3izE6MfqTP4VAsutpB/2qPwXCnKTWOuJO6A8ChRTtKOxo
        L6oFyNp146mLAqWen+c3yBkL9u8/5RFUZ/VU1IuEDfCHcCQ0P15XzgRxYXMQlZ6u
        L3v2eIJzz44tMlQrmjM3KwQT+quvBnb+maRhijK1QFW/NbxsUonemLl2JFHOICog
        Rql3y9iLutOwAoMfOQ69Fq4nPKmQVKPrHLW/8/BdI6w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=/cACM9
        Ddbiw1D+hTEKwzTopFWpx8KO4E+LJszIQsNdc=; b=MKLJMkWts6ZeCZVfR60UIY
        NVvZ5dJ5dTkGcFR070AiljDgvALU7VcSrVONIwveT1UHeGTfByYtnE0ck9yD7i32
        r1UJFNjQ+YVcIGG2SOH/5ox9tgULneo9/0QKvUPPSnRFwKvUo0ijjv44jAs/dEct
        53j5VINHNRRjR/OdQQE9giWKEjSk9hw1WPzJGPMfHXKt9knZC+0XqQIG+66VntQa
        dHEUmQML6ESlQ27ntStdZvWS34LmqbRq6I7/BH4fsGwm9aRzrJLBNyvoDOqJT67d
        kneBb+11WRQhgc+uCHYUE+zoOKHovKFLTIj6NzFqm1fhQqe+BocpfEY7RPRTGvyQ
        ==
X-ME-Sender: <xms:1OgBXbkyMoKyP65la4dal43mf2JvCUIf_NgasfBqALjMoU_6g2AksA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrudehkedguddtgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvuffkfhggtggujggfsehttdertddtredvnecuhfhrohhmpefirhgv
    ghcumffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucfkphepkeefrdekiedrkeelrd
    dutdejnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomhen
    ucevlhhushhtvghrufhiiigvpedu
X-ME-Proxy: <xmx:1OgBXRcOc005a4vwDT_DIDC7XOV2MCXYeuQit5jwQtk-fhsx9os42g>
    <xmx:1OgBXRJY86HdsAMo3mC0J3tjpa6atXxktvS95MV33jOUfdP2EhtrEg>
    <xmx:1OgBXU6f2hFCHYn6hAGPmfgAsGu3UvjL2zMjFDbSVnBIXKBnboN6yw>
    <xmx:1OgBXTdODUoflkwg0g_OBn6A4XopngURSUyaTACpM3BySsLoH-2J2g>
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        by mail.messagingengine.com (Postfix) with ESMTPA id BE89A8005B;
        Thu, 13 Jun 2019 02:10:27 -0400 (EDT)
Date:   Thu, 13 Jun 2019 08:10:26 +0200
From:   Greg KH <greg@kroah.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bich Hemon <bich.hemon@st.com>,
        Erwan Le Ray <erwan.leray@st.com>
Subject: Re: linux-next: build failure after merge of the tty tree
Message-ID: <20190613061026.GB27058@kroah.com>
References: <20190613153215.0c99f252@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190613153215.0c99f252@canb.auug.org.au>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 13, 2019 at 03:32:15PM +1000, Stephen Rothwell wrote:
> Hi Greg,
> 
> After merging the tty tree, today's linux-next build (arm
> multi_v7_defconfig) failed like this:
> 
> drivers/tty/serial/stm32-usart.c: In function 'stm32_serial_suspend':
> drivers/tty/serial/stm32-usart.c:1298:2: error: implicit declaration of function 'pinctrl_pm_select_sleep_state' [-Werror=implicit-function-declaration]
>   pinctrl_pm_select_sleep_state(dev);
>   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/tty/serial/stm32-usart.c: In function 'stm32_serial_resume':
> drivers/tty/serial/stm32-usart.c:1307:2: error: implicit declaration of function 'pinctrl_pm_select_default_state' [-Werror=implicit-function-declaration]
>   pinctrl_pm_select_default_state(dev);
>   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Caused by commit
> 
>   c70669ecef4e ("serial: stm32: select pinctrl state in each suspend/resume function")

Yeah, I think I need to just go revert that patch now, thanks.

greg k-h
