Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BA1AC4360F
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 16:06:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 305C1208E4
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 16:06:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="a2qV1y4b";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZmAVW3bI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728638AbfDAQGh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 12:06:37 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:41923 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726854AbfDAQGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 12:06:36 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id BA65B21F4D;
        Mon,  1 Apr 2019 12:06:35 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 01 Apr 2019 12:06:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=6hCqVTe65rHXP3RUmhSdqr+H52U
        uHx+5DLIASMO49NE=; b=a2qV1y4byGsqhzlZ8TEI69JMhGwPzThuAstTdwt1v2U
        kpgtfKk3AWikBUecZKRR2Sv8RqND7gDDAj9wvrpaJffvvv+epTIEoNU9f9guSRxX
        fp98FhtI0KtHB+GKtRRGzmc9LaZq2velqWff5oPqsO8W6DTqB+QjSyKu4b/HgDkQ
        ajx+Cn3XUEicMo156sA4mafgFQuPnQLxtJeDTyPn4O+BCzNN+AwhPWN/ZE+d3PTb
        jBRjTFAqib5Nw/ZP9bsA8DZV0VBcvbutA2y6U/IxvC9YFY+syNNkJTvxlehQ58Tz
        0PJD2m1rESMLNcIrGHRtemwwahvREgBbaOnXrARm5ow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=6hCqVT
        e65rHXP3RUmhSdqr+H52UuHx+5DLIASMO49NE=; b=ZmAVW3bINZ7oKhMMcDfvxF
        TzudT+fOhtschZLZ5Xi3Ql9RH1+UVSW3/Ziq4bWUPn6p1y8hqzlpNWXVszy0G7YH
        w9oKHyfxtQpvN5uH+qf6B4C2zxuGg5t5ggb5l/Io4IWvgWUBL+jJUB0GunIoWChK
        0qZE/pJqTSG9Tm6XGGW9SQUVqCW/4WzPgXG2fCevcYH66PiD4ra3APoFcppaTebC
        6FAWrpNMSyh45DvLg03Nzku0qyOq396jjP7prhhv+SEOwi3VNmK2R5ABYxoIjAxD
        PEHSwk7/x5IIBivufyRKQixgY7SZ7iqJk1ZzH0wCc6MnFJgVOcYlw73TzrZOL61w
        ==
X-ME-Sender: <xms:CzeiXLJNbXoXY20uvtvIA6_ntPxwLvgL5zvJejaz9IShhFLhJ66-pA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedutddrleeggdelgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujggfsehttdertddtredvnecuhfhrohhmpefirhgvghcu
    mffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucfkphepkeefrdekiedrkeelrddutd
    ejnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomhenucev
    lhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:CzeiXBXC9cym5R6indRCDNDyckLgkWCdsWYp9E8ba-NXa_THM0hSbw>
    <xmx:CzeiXP5a3E9fsllWV3ZyBUFtAxJybQ8rNBQH5lQiiYXDIfsnqJUHsg>
    <xmx:CzeiXD8bzDzQMMYyOx60AYD30Mt5IQh6yky6epRowpIvHkITuvASkQ>
    <xmx:CzeiXE3Ly87DAHuCI-J42Tpb1BLzmaaUtYG4IDLlXVCv4Y77gruM9A>
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        by mail.messagingengine.com (Postfix) with ESMTPA id D1AB0E49DB;
        Mon,  1 Apr 2019 12:06:34 -0400 (EDT)
Date:   Mon, 1 Apr 2019 18:06:29 +0200
From:   Greg KH <greg@kroah.com>
To:     Evalds Iodzevics <evalds.iodzevics@gmail.com>
Cc:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: missing patch
Message-ID: <20190401160629.GA20725@kroah.com>
References: <CADqhmmcCA_UjV899cHn8SOTSp89BvjMgnd5TcijCWqp6KnhdJw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADqhmmcCA_UjV899cHn8SOTSp89BvjMgnd5TcijCWqp6KnhdJw@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 30, 2019 at 06:13:16PM +0200, Evalds Iodzevics wrote:
> Hi back in the December of 2016 there was commit
> "1c52d859cb2d417e7216d3e56bb7fea88444cec9"
> 
> witch was followed shortly by  "c198b121b1a1d7a7171770c634cd49191bac4477"
> 
> Unfortunately only the first commit was later included in long-term kernel
> branches such as 4.4 and 4.9 witch left some of microcode functionality
> broken on 32 bit systems
> 
> I guess it should be easily fixed by including
> "c198b121b1a1d7a7171770c634cd49191bac4477" in those branches

Now queued up, thanks!

greg k-h
