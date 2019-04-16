Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 209CDC10F0E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 01:04:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D947C2084B
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 01:04:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="kvCi4rC4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="udv84xKi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728294AbfDPBEy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 21:04:54 -0400
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:42055 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726527AbfDPBEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 21:04:54 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 84BE81303C;
        Mon, 15 Apr 2019 21:04:50 -0400 (EDT)
Received: from imap2 ([10.202.2.52])
  by compute4.internal (MEProxy); Mon, 15 Apr 2019 21:04:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm2; bh=jodmyKZ4yhotSimlkvvA8TxyKuJ+LFH
        q9t7n5EWIY0k=; b=kvCi4rC4t+aQxH6yaY7DpBsXfSgs8IgXR11u5uoC2ocAZnM
        kZQuJyC2lIKjWgVRiLGM0xWfs96k9zYK0Os8fsbUNpPfc2yU71cBzOpPcN+8Mhdk
        XVGMRudIpsaWDd7ci6QezYa+GiQcPVJbsRT7VhuifK5JDgXdb/0FA7jHk4NN5XiM
        IaCVIvbaFgf8WKj4BstWFwHVdxuNH+QsI2E/lk55HGfVxV8t8Df/YAch1vFdgAue
        djq155Bm5EU8wcnszKJhZ5Rc8bdu5DrKdN4JphqMQzoJF2lVsKOwpQ39MnZrTKYE
        RjTW8N9eBSeXByF8jaePKWi4fiFeSGfSE2Yj5bQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=jodmyK
        Z4yhotSimlkvvA8TxyKuJ+LFHq9t7n5EWIY0k=; b=udv84xKi5kx7WrzLSEzMvF
        LXvfyqlafNN6OZ+9BGcpWu5SQCCmtkBmzf3lLb/4DScWa952Uxj/VzVk1DF1u/Iy
        OzgUjEpRtpxrD4C8+NIh0oAgo1tf7yX7T9/oASIPY1sdtE4vmnMwkoRnnXTuG8ZO
        AJM9O0Kl6bNGEjQNycS+PnCrxt/K+0FEr6VFzWdc3HxEU0AYrgT4Vsl7yp0WgyLx
        j/KN2uAWjDj82/2OLFnO5jtO45Di1EbS8OZ0ZUg+qp1gyl23a+0VqzVYNoibU1LW
        5CVnaXNkh/H2nnxEaNbMYWGhqvcowHv0HMF6Xcbd9ph4ajOheZYNZCLhRg9wRR5w
        ==
X-ME-Sender: <xms:MSq1XH2-An056Lh2O8Y5Kkqlu8AtAQM0xWrBdrCuF3BtpVeZzZ_86g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrfedtgdegtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvufgtsehttdertderreejnecuhfhrohhmpedftehnughr
    vgifucflvghffhgvrhihfdcuoegrnhgurhgvfiesrghjrdhiugdrrghuqeenucfrrghrrg
    hmpehmrghilhhfrhhomheprghnughrvgifsegrjhdrihgurdgruhenucevlhhushhtvghr
    ufhiiigvpedt
X-ME-Proxy: <xmx:MSq1XKsKuidZNWpAzP1aoOI4AhDiGYwZOMaVKDvawA3ShbL-Ni_mXg>
    <xmx:MSq1XADEAOvn_hChNpTjoHsg6_nYQ0sGxqD-bTw2hUf0xMdVoW6s6w>
    <xmx:MSq1XG-CSMNziSoTQcwRVI6cJmglumhXjZEgg786_pUbvACcqwIDNg>
    <xmx:Miq1XD7lBnHkxIHWg2MQr9i4iG2OX47X8BEh8di_nV8kbdw66RuRiA>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 3F2907C199; Mon, 15 Apr 2019 21:04:49 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.1.6-332-g22ddc6a-fmstable-20190412v1
Mime-Version: 1.0
X-Me-Personality: 52947553
Message-Id: <93fd2cb2-b3cd-4b7f-b187-eec62ce49723@www.fastmail.com>
In-Reply-To: <20190415121235.255028-2-tmaimon77@gmail.com>
References: <20190415121235.255028-1-tmaimon77@gmail.com>
 <20190415121235.255028-2-tmaimon77@gmail.com>
Date:   Mon, 15 Apr 2019 21:04:48 -0400
From:   "Andrew Jeffery" <andrew@aj.id.au>
To:     "Tomer Maimon" <tmaimon77@gmail.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, arnd@arnd.de,
        "Rob Herring" <robh+dt@kernel.org>, mark.rutland@arm.com,
        "Nancy Yuen" <yuenn@google.com>,
        "Patrick Venture" <venture@google.com>,
        "Brendan Higgins" <brendanhiggins@google.com>,
        "Avi Fishman" <avifishman70@gmail.com>,
        "Joel Stanley" <joel@jms.id.au>
Cc:     linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        openbmc@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: =?UTF-8?Q?Re:_[PATCH_v1_1/2]_dt-binding:_misc:_Add_common_LPC_snoop_docu?=
 =?UTF-8?Q?mentation?=
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 15 Apr 2019, at 21:51, Tomer Maimon wrote:
> Added device tree binding documentation for Nuvoton BMC
> NPCM BIOS Post Code (BPC) and Apeed AST2500 LPC snoop.
> The LPC snoop monitoring two configurable I/O addresses
> written by the host on Low Pin Count (LPC) bus.
> 
> Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
> ---
>  .../devicetree/bindings/misc/lpc-snoop.txt         | 27 ++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/misc/lpc-snoop.txt
> 
> diff --git a/Documentation/devicetree/bindings/misc/lpc-snoop.txt 
> b/Documentation/devicetree/bindings/misc/lpc-snoop.txt
> new file mode 100644
> index 000000000000..7deac244ef9d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/misc/lpc-snoop.txt
> @@ -0,0 +1,27 @@
> +LPC snoop interface
> +
> +The LPC snoop (BIOS Post Code) interface can monitor
> +two configurable I/O addresses written by the host on
> +the Low Pin Count (LPC) bus.

Wrapping looks kind of odd and there's a missing newline at the
end of the file, but for the content:

Reviewed-by: Andrew Jeffery <andrew@aj.id.au>

> +
> +Nuvoton NPCM7xx LPC snoop supports capture double words,
> +when using capture double word only I/O address 1 is monitored.
> +
> +Required properties for lpc-snoop node
> +- compatible   : "nuvoton,npcm750-lpc-bpc-snoop" for Poleg NPCM7XX
> +                 "aspeed,ast2500-lpc-snoop" for Aspeed AST2500.
> +- reg          : specifies physical base address and size of the 
> registers.
> +- interrupts   : contain the LPC snoop interrupt with flags for 
> falling edge.
> +- snoop-ports  : contain monitor I/O addresses, at least one monitor 
> I/O
> +                 address required
> +
> +Optional property for NPCM7xx lpc-snoop node
> +- nuvoton,lpc-en-dwcapture : enable capture double words support.
> +
> +Example:
> +	lpc-snoop: lpc_snoop@f0007040 {
> +		compatible = "nuvoton,npcm750-lpc-bpc-snoop";
> +		reg = <0xf0007040 0x14>;
> +		snoop-ports = <0x80>;
> +		interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
> +	};
> \ No newline at end of file
> -- 
> 2.14.1
> 
>
