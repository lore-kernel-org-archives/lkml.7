Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4EF1C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 14:16:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA5E320679
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 14:16:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="fYzlzc0a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732034AbfFTOQJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 10:16:09 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:46274 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726686AbfFTOQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 10:16:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1561040165; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=61YqVHCdsBReXxm/3QTsbGF8fRfNDuePQ2kaErTMnAs=;
        b=fYzlzc0aSLNqJ4oz7Y5SJxxDVNalZjIKYNa1B6M7JF5mbOthBfCzouM68lL+Ivzzx3sfxk
        RLKq2Mqf15Xe+loGSqQmQ1aIFirnXaGY2YNuIyIr5T+8ehvWwXRzWh36uARG+zImqflEtw
        +RnVcMiADHF6PqCywgI6huLIZX+Q270=
Date:   Thu, 20 Jun 2019 16:15:59 +0200
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v5 2/2] DRM: Add KMS driver for the Ingenic JZ47xx SoCs
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, od@zcrc.me,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Artur Rojek <contact@artur-rojek.eu>
Message-Id: <1561040159.1978.0@crapouillou.net>
In-Reply-To: <20190619122622.GB29084@ravnborg.org>
References: <20190603152331.23160-1-paul@crapouillou.net>
        <20190603152331.23160-2-paul@crapouillou.net>
        <20190619122622.GB29084@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le mer. 19 juin 2019 =E0 14:26, Sam Ravnborg <sam@ravnborg.org> a =E9crit=20
:
> Hi Paul.
>=20
> On Mon, Jun 03, 2019 at 05:23:31PM +0200, Paul Cercueil wrote:
>>  Add a KMS driver for the Ingenic JZ47xx family of SoCs.
>>  This driver is meant to replace the aging jz4740-fb driver.
>>=20
>>  This driver does not make use of the simple pipe helper, for the=20
>> reason
>>  that it will soon be updated to support more advanced features like
>>  multiple planes, IPU integration for colorspace conversion and=20
>> up/down
>>  scaling, support for DSI displays, and TV-out and HDMI outputs.
>>=20
>>  Signed-off-by: Paul Cercueil <paul@crapouillou.net>
>>  Tested-by: Artur Rojek <contact@artur-rojek.eu>
>>  ---
>>=20
>>  Notes:
>>      v2: - Remove custom handling of panel. The panel is now=20
>> discovered using
>>      	  the standard API.
>>      	- Lots of small tweaks suggested by upstream
>>=20
>>      v3: - Use devm_drm_dev_init()
>>      	- Update compatible strings to -lcd instead of -drm
>>      	- Add destroy() callbacks to plane and crtc
>>      	- The ingenic,lcd-mode is now read from the bridge's DT node
>>=20
>>      v4: Remove ingenic,lcd-mode property completely. The various=20
>> modes are now
>>      	deduced from the connector type, the pixel format or the bus=20
>> flags.
>>=20
>>      v5: - Fix framebuffer size incorrectly calculated for 24bpp=20
>> framebuffers
>>      	- Use 32bpp framebuffer instead of 16bpp, as it'll work with=20
>> both
>>      	  16-bit and 24-bit panel
>>      	- Get rid of drm_format_plane_cpp() which has been dropped=20
>> upstream
>>      	- Avoid using drm_format_info->depth, which is deprecated.
> In the drm world we include the revision notes in the changelog.
> So I did this when I applied it to drm-misc-next.
>=20
> Fixed a few trivial checkpatch warnings about indent too.
> There was a few too-long-lines warnings that I ignored. Fixing them
> would have hurt readability.

Thanks.

> I assume you will maintain this driver onwards from now.
> Please request drm-misc commit rights (see
> https://www.freedesktop.org/wiki/AccountRequests/)
> You will need a legacy SSH account.

I requested an account here:
https://gitlab.freedesktop.org/freedesktop/freedesktop/issues/162

> And you should familiarize yourself with the maintainer-tools:
> https://drm.pages.freedesktop.org/maintainer-tools/index.html
>=20
> For my use I use "dim update-branches; dim apply; dim push
> So only a small subset i needed for simple use.
>=20
> 	Sam

=

