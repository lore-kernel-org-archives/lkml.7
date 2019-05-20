Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB73FC04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 17:20:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0D60208C3
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 17:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558372844;
	bh=y0qgGqkaWE/kipSaEaPyyR8jq8PGYKXzIS0tbcLGqT8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=WToBCR1BzzpYKFs9O8zbVjhIbEUx7g9naOfkey0Roi6XHFrxicA+wFQEAoUrZLHIa
	 jMWNRAfGooxwvaMo9Rd8ziDgsjWC1jE3oluz6UasP4so3C4fSHElc5yPcu8PQTble2
	 WzKRba0XYZ1yKX0I/Z8w07sgZBV7r6iyEUiPanUs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392818AbfETRUn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 13:20:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:37264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733069AbfETRUn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 13:20:43 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BA7F720675;
        Mon, 20 May 2019 17:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558372843;
        bh=y0qgGqkaWE/kipSaEaPyyR8jq8PGYKXzIS0tbcLGqT8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T7LDFzx1/j26xdrmdGnd4Vxk/tKpX7CER1YFC7xEGVrpLONxw97rPMieYRiUi4u67
         9+K/Y+woV2VZBB/bKo7nxunaBn+FEQtPoFiOQfiD7j/JzUZuBGKAbfcikO+wPJ+Eoq
         2qXVXVKUCa9CCxJTkx1bTlVpUNre2LKuXkUMmmjo=
Date:   Mon, 20 May 2019 13:20:41 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Julia Lawall <julia.lawall@lip6.fr>
Cc:     Pavel Machek <pavel@ucw.cz>, wen.yang99@zte.com.cn,
        Markus.Elfring@web.de, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        yamada.masahiro@socionext.com, michal.lkml@markovi.net,
        nicolas.palix@imag.fr
Subject: Re: Coccinelle: semantic patch for missing of_node_put
Message-ID: <20190520172041.GH11972@sasha-vm>
References: <201905171432571474636@zte.com.cn>
 <alpine.DEB.2.20.1905170912590.4014@hadrien>
 <20190520093303.GA9320@atrey.karlin.mff.cuni.cz>
 <alpine.DEB.2.21.1905201152040.2543@hadrien>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1905201152040.2543@hadrien>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 20, 2019 at 11:52:37AM +0200, Julia Lawall wrote:
>
>
>On Mon, 20 May 2019, Pavel Machek wrote:
>
>> Hi!
>>
>> > A semantic patch has no access to comments.  The only thing I can see to
>> > do is to use python to interact with some external tools.  For example,
>> > you could write some code to collect the comments in a file and the lines
>> > on which they occur, and then get the comment that most closely precedes
>> > the start of the function.
>>
>> How dangerous is missing of_node_put? AFAICT it will only result into
>> very small, one-time memory leak, right?
>>
>> Could we make sure these patches are _not_ going to stable? Leaking
>> few bytes once per boot is not really a serious bug.
>
>Sasha,
>
>Probably patches that add only of_node_put should not be auto selected for
>stable.

I can filter them out, but those are fixes, right? Why are we concerned
about them making it into -stable?

--
Thanks,
Sasha
