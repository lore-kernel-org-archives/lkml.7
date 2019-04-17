Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE8D7C10F12
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 08:56:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 691BC21841
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 08:56:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=g001.emailsrvr.com header.i=@g001.emailsrvr.com header.b="mnD7dALw";
	dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b="NYOal51U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731398AbfDQI4F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 04:56:05 -0400
Received: from smtp97.ord1c.emailsrvr.com ([108.166.43.97]:51871 "EHLO
        smtp97.ord1c.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726237AbfDQI4E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 04:56:04 -0400
Received: from smtp13.relay.ord1c.emailsrvr.com (localhost [127.0.0.1])
        by smtp13.relay.ord1c.emailsrvr.com (SMTP Server) with ESMTP id 8D7D2A0129;
        Wed, 17 Apr 2019 04:56:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=g001.emailsrvr.com;
        s=20190322-9u7zjiwi; t=1555491363;
        bh=hZQS19k6P1fodxPEqOyIMI6K/jrfsT9Rwfe+HivYjPI=;
        h=Subject:To:From:Date:From;
        b=mnD7dALwiEAO9UNGxoWpTnmC+Hcs+xxS3lqN0RXlyWIVKuZpmmYQ+l0ckJUhBKKyV
         2Cin2bl6uLCJQZ8DdCCLcv3Q0NL91aHVNn5EHJuelEHA4XB9ZyjrAfsd86UhBKCR9B
         AN0ijg3e/fMVA4bA+ya/ufa2YeesXBWiJE63giUU=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
        s=20190130-41we5z8j; t=1555491363;
        bh=hZQS19k6P1fodxPEqOyIMI6K/jrfsT9Rwfe+HivYjPI=;
        h=Subject:To:From:Date:From;
        b=NYOal51UI2wbLIeQNhrg1o4Li/l+P0GyxAdIaYbBDxqHKqi3YAm7Dik81KSgHRbp4
         zz73q0qcSsYmczWMg9gkcS6+r0qlxZHcw5aNwoLQ7wUMEn8K4/7R9yd7sKva09YX6e
         +Jz7MN07fkk2/T/u5AVm3+s4I4OyWWzzKwPS396A=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp13.relay.ord1c.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id AD646A00EE;
        Wed, 17 Apr 2019 04:56:02 -0400 (EDT)
X-Sender-Id: abbotti@mev.co.uk
Received: from [10.0.0.62] (remote.quintadena.com [81.133.34.160])
        (using TLSv1.2 with cipher AES128-SHA)
        by 0.0.0.0:465 (trex/5.7.12);
        Wed, 17 Apr 2019 04:56:03 -0400
Subject: Re: [PATCH] staging: comedi: use help instead of ---help--- in
 Kconfig
To:     Moses Christopher <moseschristopherb@gmail.com>
Cc:     H Hartley Sweeten <hsweeten@visionengravers.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Spencer E. Olson" <olsonse@umich.edu>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
References: <20190416170900.6613-1-moseschristopherb@gmail.com>
From:   Ian Abbott <abbotti@mev.co.uk>
Organization: MEV Ltd.
Message-ID: <868da68d-998e-15d7-0199-742cb0216fda@mev.co.uk>
Date:   Wed, 17 Apr 2019 09:56:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190416170900.6613-1-moseschristopherb@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/04/2019 18:08, Moses Christopher wrote:
>    - Resolve the following warning from the Kconfig,
>      "WARNING: prefer 'help' over '---help---' for new help texts"
> 
> Signed-off-by: Moses Christopher <moseschristopherb@gmail.com>
> ---
>   drivers/staging/comedi/Kconfig | 254 ++++++++++++++++-----------------
>   1 file changed, 127 insertions(+), 127 deletions(-)
> 

Looks good, thanks!

Reviewed-by: Ian Abbott <abbotti@mev.co.uk>

-- 
-=( Ian Abbott <abbotti@mev.co.uk> || Web: www.mev.co.uk )=-
-=( MEV Ltd. is a company registered in England & Wales. )=-
-=( Registered number: 02862268.  Registered address:    )=-
-=( 15 West Park Road, Bramhall, STOCKPORT, SK7 3JZ, UK. )=-
