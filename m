Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF4EAC10F06
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 00:29:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A35F9214AF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 00:29:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552350587;
	bh=Spbq4MUY2xUjcMcLIV/0wT2d7SS855QEoK1R79XxF+Q=;
	h=Date:From:To:Subject:References:In-Reply-To:List-ID:From;
	b=rp9SJ1yiehtgBG338b2mHdhjuygmsM4As90Z0za4umJlyY5QxUulBKrqglyMvd9UT
	 IjMj/mn38tR+dnMoxh65FHBijhCzdbwfXEVSR1EskgWDsK9dfFZD6sdZzRkzH1d/pE
	 6c7I+NtrzTOQrWSF2rb760evF8br4+uffR+If7+E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbfCLA3q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 20:29:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:35222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725880AbfCLA3q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 20:29:46 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5F4722087F;
        Tue, 12 Mar 2019 00:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552350585;
        bh=Spbq4MUY2xUjcMcLIV/0wT2d7SS855QEoK1R79XxF+Q=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=fKUpXWLTEUR1bPGt4qB3dmxrYPhfYju/zZsSN/9nx+RqL8RNrloouosCaEVKBBcVN
         YkMyHd4Qsjz8/7LkFk/mZwLqLsEQBAtQ+tAF9B8mdnsZoEr0bkBZ8MVnh2gciL+Omp
         cV6pjcbbyJVKNk1216HXTXOF0DQkhU0gtZ2N39JQ=
Date:   Mon, 11 Mar 2019 20:29:44 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Borislav Petkov <bp@suse.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Russ Anderson <rja@hpe.com>,
        Dimitri Sivanich <sivanich@hpe.com>,
        Steve Wahl <steve.wahl@hpe.com>,
        Mike Travis <mike.travis@hpe.com>,
        Andy Shevchenko <andy@infradead.org>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        Darren Hart <dvhart@infradead.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, x86-ml <x86@kernel.org>
Subject: Re: Please revert 7212e37cbdf9 from 4.4-stable
Message-ID: <20190312002944.GL158926@sasha-vm>
References: <20190311134814.GC30367@sarge.linuxathome.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190311134814.GC30367@sarge.linuxathome.me>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 11, 2019 at 01:48:14PM +0000, Hedi Berriche wrote:
>Hi Greg,
>
>Could you please revert
>
>	7212e37cbdf9 x86/platform/UV: Use efi_runtime_lock to serialise BIOS calls
>
>from 4.4-stable?
>
>In 4.4-stable efi_runtime_lock as defined in drivers/firmware/efi/runtime-wrappers.c
>is a spinlock (given it predates commit dce48e351c0d) and commit
>
>	f331e766c4be x86/platform/UV: Use efi_runtime_lock to serialise BIOS calls
>
>which 7212e37cbdf9 is a backport of, needs it to be a semaphore.

I've queued up the revert. I'm not sure how it ended up on 4.4 to begin
with; sorry about that and thank you.

--
Thanks,
Sasha
