Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2168DC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 02:38:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA2142087E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 02:38:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553654284;
	bh=sWVTiCQwoIW74kuAKGEEft9M1jg713UIbxyMJSVBA0M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Yg8Ja7exQfj2xAmDqAw1fIpIVONUJQS0HFyOsZJI/zdIODjV+MetYnCTPedFxFLqF
	 1aMxqJNqb+/r8hMeCjUvVuOHb0cWxnrXqoTeOgiRlhAppd/dbONBrLwjfJbk9vPTpb
	 8uRF4qAw9uobDs/RQGPgBHvEF7OeqFh65R0QM0Dg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732918AbfC0CiC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 22:38:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:42842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727452AbfC0CiC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 22:38:02 -0400
Received: from localhost (mobile-166-137-177-030.mycingular.net [166.137.177.30])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CBAB820811;
        Wed, 27 Mar 2019 02:38:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553654281;
        bh=sWVTiCQwoIW74kuAKGEEft9M1jg713UIbxyMJSVBA0M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kcGBC218jmEaxNC/iM+Pn4WJ68ufdrW8DiFYTlY7WMcJHp29kQ62o1L/83S5HzA4D
         Md7VvAuqzUNiig13Bz73sKhej/JRK3w2F1YQeT/6rn1o7IRrNCPMkDsB/l56caQhZR
         TT5VN6c5NTBlsQuskkzBvFX1qGRQyTFNy/atWQ7o=
Date:   Wed, 27 Mar 2019 11:37:57 +0900
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Ronald =?iso-8859-1?Q?Tschal=E4r?= <ronald@innovation.ch>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Lukas Wunner <lukas@wunner.de>,
        Federico Lorenzi <federico@travelground.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/4] driver core: add dev_print_hex_dump() logging
 function.
Message-ID: <20190327023757.GB20766@kroah.com>
References: <20190327014807.7472-1-ronald@innovation.ch>
 <20190327014807.7472-4-ronald@innovation.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190327014807.7472-4-ronald@innovation.ch>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 26, 2019 at 06:48:06PM -0700, Ronald Tschalär wrote:
> This is the dev_xxx() analog to print_hex_dump(), using dev_printk()
> instead of straight printk() to match other dev_xxx() logging functions.
> ---
>  drivers/base/core.c    | 43 ++++++++++++++++++++++++++++++++++++++++++
>  include/linux/device.h | 15 +++++++++++++++
>  2 files changed, 58 insertions(+)

No signed-off-by?

Anyway, no, please do not do this.  Please do not dump large hex values
like this to the kernel log, it does not help anyone.

You can do this while debugging, sure, but not for "real" kernel code.

Worst case, just create a debugfs file for your device that you can read
the binary data from if you really need it.  For any "normal" operation,
this is not something that you should ever need.

thanks,

greg k-h
