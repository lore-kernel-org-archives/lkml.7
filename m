Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB883C10F11
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 00:27:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82ED821773
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 00:27:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="Qq2VnWH9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="zSIdIW41"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbfDKA1o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 20:27:44 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:36677 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726096AbfDKA1o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 20:27:44 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id EAED236FF;
        Wed, 10 Apr 2019 20:27:42 -0400 (EDT)
Received: from imap2 ([10.202.2.52])
  by compute4.internal (MEProxy); Wed, 10 Apr 2019 20:27:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm2; bh=y7TBfW/sgVfj1t2WjLCnmvZRvt4FY7U
        Pg5XrNYBI2h4=; b=Qq2VnWH94NlmzXMxWGK00InBr8qiQ+O93oMoU0KimXH5OxV
        YE/qgDt3JCPX1GEmU7AHYvAK6M1a/2xTPcMMLrvj3GgexJnIdtRqyS92wdmWiaFn
        jnKa44icPo9yZ04TbBLDVi/8Ukls99ACPIwow4vvb4Z2SBnwFfz60V8oOZ/TmIe1
        bCf7AKrFlGY7okJ1Q2lO0QmRI1dfozNjCZWoiBngRjKrBAbR7adyhKEFzsd2VaZN
        ilAwGBXEBtCaTpuWOfgfw7Nxo0UG7jJdA4pUHHs2EWeDaBqu2MoxZkZT5UGSgVfY
        xIGO+YXzp30XKFg8FTJtlSCgz04Hg/UA/7t+6Pw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=y7TBfW
        /sgVfj1t2WjLCnmvZRvt4FY7UPg5XrNYBI2h4=; b=zSIdIW41EGBfuGbcuoJCVD
        iskVMGbCWbe0Eaq7UywN0z3eg3XPJDqjXFvcVp8WU19sVirQo8U5EVnkcMfL2Of6
        qZJg/2URnV7Zq6eGYofXuyV33+t9cLhoUD7qqH8P4LgGHq78IFCUQeYiXjfEhamQ
        hWGmuxU4GrhM8U0jlWsQg6tURsnF2WaH+H/ACuHAalY3466k7MwZvNb6y+M16I7Y
        +7E6/nsPM+2nNs47KPFw6L5hYilKCvkRCBbCt7FVbGTWXPmV+Cx+dEz3NZkS1wtl
        wz+qvHKbQd3gZM7vgqbxPC/JVyf0k/x1TzafrSoBwtSMpIi0L+k4ABXoUvLYUkYA
        ==
X-ME-Sender: <xms:_YmuXAO1zA1j0dIfPgqHcjeF-Q3pnnncCSl-3Nnjin7qrxupa8QcwA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrudekgddvlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvufgtsehttdertderreejnecuhfhrohhmpedftehnughr
    vgifucflvghffhgvrhihfdcuoegrnhgurhgvfiesrghjrdhiugdrrghuqeenucfrrghrrg
    hmpehmrghilhhfrhhomheprghnughrvgifsegrjhdrihgurdgruhenucevlhhushhtvghr
    ufhiiigvpedt
X-ME-Proxy: <xmx:_YmuXALOPpPZVSUrnz1g-K5qsXoN4shnuNbbyihzuOflXKxPX4-1iA>
    <xmx:_YmuXBZkWcIL4DTZHRkP2IyfiX5dZ5ebbVchkoPHNkvaAdmoDECzYg>
    <xmx:_YmuXJm0ZqXi7nqcdAIztCh4AaTjkDM8Z4giO5ab1chwZKbKrrEn1Q>
    <xmx:_omuXNUDPT8O9uSHa9WBQYaP_GSxFpXGnvTBOt03nOP8kz8tGmo_dw>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 8357A7C1B9; Wed, 10 Apr 2019 20:27:41 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.1.6-329-gf4aae99-fmstable-20190329v1
Mime-Version: 1.0
X-Me-Personality: 52947553
Message-Id: <e2b1820f-070e-4d8d-81d2-6dd8f564a861@www.fastmail.com>
In-Reply-To: <2088d3de719397153639c5afdce53b73fe75603a.1554923967.git.mchehab+samsung@kernel.org>
References: <cover.1554923967.git.mchehab+samsung@kernel.org>
 <2088d3de719397153639c5afdce53b73fe75603a.1554923967.git.mchehab+samsung@kernel.org>
Date:   Wed, 10 Apr 2019 20:27:41 -0400
From:   "Andrew Jeffery" <andrew@aj.id.au>
To:     "Mauro Carvalho Chehab" <mchehab+samsung@kernel.org>,
        "Linux Doc Mailing List" <linux-doc@vger.kernel.org>
Cc:     "Mauro Carvalho Chehab" <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, "Jonathan Corbet" <corbet@lwn.net>,
        "Jean Delvare" <jdelvare@suse.com>,
        "Guenter Roeck" <linux@roeck-us.net>,
        "Joel Stanley" <joel@jms.id.au>, linux-hwmon@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org
Subject: =?UTF-8?Q?Re:_[PATCH_v2_10/21]_docs:_hwmon:_aspeed-pwm-tacho:_convert_to?=
 =?UTF-8?Q?_ReST_format?=
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 11 Apr 2019, at 04:54, Mauro Carvalho Chehab wrote:
> Convert aspeed-pwm-tacho to ReST format, in order to allow it to
> be parsed by Sphinx.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

Acked-by: Andrew Jeffery <andrew@aj.id.au>

> ---
>  Documentation/hwmon/aspeed-pwm-tacho | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/hwmon/aspeed-pwm-tacho 
> b/Documentation/hwmon/aspeed-pwm-tacho
> index 7cfb34977460..6dcec845fbc7 100644
> --- a/Documentation/hwmon/aspeed-pwm-tacho
> +++ b/Documentation/hwmon/aspeed-pwm-tacho
> @@ -15,8 +15,10 @@ controller supports up to 16 tachometer inputs.
>  
>  The driver provides the following sensor accesses in sysfs:
>  
> +=============== ======= =====================================================
>  fanX_input	ro	provide current fan rotation value in RPM as reported
>  			by the fan to the device.
>  
>  pwmX		rw	get or set PWM fan control value. This is an integer
>  			value between 0(off) and 255(full speed).
> +=============== ======= =====================================================
> -- 
> 2.20.1
> 
>
