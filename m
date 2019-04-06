Return-Path: <SRS0=Ybdz=SI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28399C282DC
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 14:20:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED7412146F
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 14:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554560440;
	bh=qBK9K5naF2mwaxcF2xr9QmmsWcAsBZegB05dD5oTEIk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ipVGsqElVvQeQqG4yQWcGKpBQuFRsOyI/nFloxFawmBC+xJpM/Cy3GbxRRJrlNvkb
	 GkLcYb+LeU8flxAF7GdhbEj2CyJFNimRZCGeSt/R6LPf/KsRT3azE3/yl8e256WJWJ
	 O9qsawocLHaUK/JH/f7Sb9q2BeftUG/12g/l8S20=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbfDFOUi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Apr 2019 10:20:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:54648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726404AbfDFOUi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Apr 2019 10:20:38 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5BAA0213A2;
        Sat,  6 Apr 2019 14:20:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554560437;
        bh=qBK9K5naF2mwaxcF2xr9QmmsWcAsBZegB05dD5oTEIk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nxSwyMP15caD5OPPf7dyoSjh6HQsUxOAESPwWFO6bnOi061KDAEyqU7riHEo+NJMV
         VnDyGGJ+c0JyebSpu2YGuz9REIyQC9qdFiouUsDiPv+Zg/H6NGRRoczaLI5GLd7Q8h
         4WWgjMjVbPzDtj6AZWZkxlauxCKTKGgkghf4ImYk=
Date:   Sat, 6 Apr 2019 10:20:36 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Cc:     Slavomir Kaslev <kaslevs@vmware.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>
Subject: Re: [PATCH 5.0 047/246] fs: Make splice() and tee() take into
 account O_NONBLOCK flag on pipes
Message-ID: <20190406142036.GD2935@sasha-vm>
References: <20190404084619.236418459@linuxfoundation.org>
 <20190404084620.671108728@linuxfoundation.org>
 <3fa8b886ccb1ea2229344091be9ac769021f69a4.camel@vmware.com>
 <20190404173200.GB29613@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190404173200.GB29613@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 04, 2019 at 07:32:00PM +0200, gregkh@linuxfoundation.org wrote:
>On Thu, Apr 04, 2019 at 04:16:57PM +0000, Slavomir Kaslev wrote:
>> On Thu, 2019-04-04 at 10:45 +0200, Greg Kroah-Hartman wrote:
>> > 5.0-stable review patch.  If anyone has any objections, please let me
>> > know.
>> >
>> > ------------------
>> >
>> > [ Upstream commit ee5e001196d1345b8fee25925ff5f1d67936081e ]
>> >
>> > The current implementation of splice() and tee() ignores O_NONBLOCK
>> > set
>> > on pipe file descriptors and checks only the SPLICE_F_NONBLOCK flag
>> > for
>> > blocking on pipe arguments.  This is inconsistent since splice()-ing
>> > from/to non-pipe file descriptors does take O_NONBLOCK into
>> > consideration.
>> >
>> > Fix this by promoting O_NONBLOCK, when set on a pipe, to
>> > SPLICE_F_NONBLOCK.
>>
>> [...]
>>
>> > This change does have potential of breaking users who don't expect
>> > EAGAIN from splice() when SPLICE_F_NONBLOCK is not set.  OTOH
>> > programs
>> > that set O_NONBLOCK and don't anticipate EAGAIN are arguably
>> > buggy[2].
>>
>> Hi Greg,
>>
>> Can you drop this one from the stable queues? We discussed it with
>> Sasha[1] already in the autosel patches thread.
>>
>> [1] https://lkml.org/lkml/2019/4/3/811
>
>Dropped from everywhere now.
>
>Sasha, how did this still get in?

Sorry about that, I dropped it from the wrong local branch :(

--
Thanks,
Sasha
