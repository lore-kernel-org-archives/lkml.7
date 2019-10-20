Return-Path: <SRS0=ATYp=YN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72D51CA9EA9
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Oct 2019 08:21:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25F8021928
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Oct 2019 08:21:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="TBSROF6s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726263AbfJTIUq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 20 Oct 2019 04:20:46 -0400
Received: from mout.web.de ([212.227.17.11]:42615 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725893AbfJTIUq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Oct 2019 04:20:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1571559628;
        bh=xwmRSOTZtbdI+Pcsog91Q9nfAPFlwKlFCuhq3pODYvk=;
        h=X-UI-Sender-Class:To:From:Subject:Cc:Date;
        b=TBSROF6sIeC0uP/xcpjPafxovE+8VKYL83bYyKwsxyy3S8PWlRUeXhlrA6SUbEcWr
         7EOfwf7HTSFD0SEXyXRWDAIJDwfpDyBmQn/K8hqujK+sLiDCVoRAH9b/78FDTCZttd
         9g4Ooi5sjkh5ENW3wFKOmdJDgk9juWTYxN0p1ts4=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.48.112.181]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Lb1wz-1hcLRd2HIP-00kcIJ; Sun, 20
 Oct 2019 10:20:28 +0200
To:     dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
From:   Markus Elfring <Markus.Elfring@web.de>
Subject: drm/gma500: Checking a get_config_mode() call in
 mdfld_dsi_output_init()
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org, Aditya Pakki <pakki001@umn.edu>,
        Kangjie Lu <kjlu@umn.edu>, Navid Emamdoost <emamd001@umn.edu>,
        Stephen McCamant <smccaman@umn.edu>
Message-ID: <0f501ca6-0b4f-0ccd-c366-bed2a10fde03@web.de>
Date:   Sun, 20 Oct 2019 10:20:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:5fPZBLxTESUv9+AyIdrfFxJAwqNzGS297OtwOo5jOeiJZxOpbc4
 pAJgks8CK8heLDg9EoRR03jnoZouUHXqSrhRE8dzauYe0zUDgXieUo45SDJ1hugB4OQ4XcT
 QgUBDAlnVG/GsLrPxMzW6jZY2qqWgiIiWisvIHcjkjkABkdv2ccv0vYdASO2DeHOtav36Rf
 duAiDfFrydELtoQqLFzqA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Mvr3qLK9PJ8=:ShNO/BdanB9dULxAsT+QrP
 LMNskNNwmgB9+KATPeYRfl4peHyxnRcZmYf8XXpBSGyeld8Z9vmFA3fc2vN2o0UP2y3wgUmuP
 +ijnQPq/P1SmYKyq6TYtk+zFW3r4g22vQsffcnIir73nmeb64gkixcraq/0h79uhjaj/fsQ12
 wWzKdn+EjNmryX+FmiHhXZw4KjPM/aDpEatz7hGK/flq+FvlTXLt9LNPncQZVbeYcrLBSu5IB
 BzFNxJSoALiWOSXhdCEVN7ccOrMUhxdNiGxrVCl4691UdHkiUKJF1U2+rDRzQkyXxUUTzs/OZ
 tAfIqEm7u5oNSoIdU8oSqMGfFHKhUKOKyErYmVR+n3akmS6ZGNpWIJLULewQVml+G7OEm9GgH
 hqXrRAKrH/UJd6wERw/akQozlXorRNHO8X2zZeFEuvmwLC7UX2OW6xwWtjW2QCbxuIA5h8yRU
 9/ySdbGgI1eI20SgssisaWB2T+qXCpo1aGkAvvpJtQgmwZauxEtXzLhFYu7N0bABdelA9gYC+
 cXfIku0Ok4mGAiWS5vm6k7GaOcsIkkDD3BidrRwrUzjHRYk7dfETe5mPLiPSpN+MU0rDn1s9i
 mXeJ4R2LUWVcwFVATtz0CPRyC7QZRTEtRR5x4/eZLyE8/SJF5uCZUyHyp3/JzJg0aE9e2n5cq
 s1j+A4GVZN6kXSVIfGAB9lAho7kt/Sc2dXjBR0S26lrRmm0BVhs1UC/ZqqoOWeFdeWTtpn6NJ
 jneR1mN/AVu2UglizDS9Vyp75RuDEqqTQcuOUrenu56ZESuKNyMiXkS5obXsyFjvr23HQxO2m
 NByH3EzqEsSM9igbmKm9K7Nu2zm9e9e0DKxfX65RagYAv9k6jwHDZLsIOwfvIRFdY0j7LkpyE
 GM8J23yv0gBX5KrFec/gtGa6t9j5sbQlfdRzHAXanRPdZmPOOXG7jUQkpTDTCrQMJUJmvSlvl
 SXZ/kpj0xwReF90joMxmmSahBFEoZ/HmdPrluXIBzZaQtb6cUg1h9NYAgLr6xYvDHf3Omi9/e
 NwoxAq4+kCeh/+t9KvCe2gS3Ni50VvUlEd+utZvwpmerX1OHRk5ct1F9+gc1KxVy75px5czm7
 FrOcg6wTx7yw1uZJDAxBQsmDVoB42db4u2Lhw08whdblvWlZU1tnMskeBzq0tQsYgMSEZmPhx
 jLXNMWcJC9/if832uZ5W+g1jnzjiAUkfmSJgqpfE2R7I6ljztYASYHdiLHNjI921GHvjJ/9lh
 L0ejrKouyIik8wQpYKGR2a7fWoousiEbECfmduNmdrBIJ34ojm6QWIBQ5vlc=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I tried another script for the semantic patch language out.
This source code analysis approach points a call of the member
function =E2=80=9Cget_config_mode=E2=80=9D out for further considerations
according to the implementation of the function =E2=80=9Cmdfld_dsi_output_=
init=E2=80=9D.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/dr=
ivers/gpu/drm/gma500/mdfld_dsi_output.c?id=3D531e93d11470aa2e14e6a3febef50=
d9bc7bab7a1#n523
https://elixir.bootlin.com/linux/v5.4-rc2/source/drivers/gpu/drm/gma500/md=
fld_dsi_output.c#L523

=E2=80=A6
	dsi_config->fixed_mode =3D p_vid_funcs->get_config_mode(dev);
	if (p_vid_funcs->get_panel_info(dev, pipe, &dsi_panel_info))
			goto dsi_init_err0;
=E2=80=A6
	dsi_config->mode =3D dsi_config->fixed_mode;
=E2=80=A6
	if (!dsi_config->fixed_mode) {
		DRM_ERROR("No pannel fixed mode was found\n");
		goto dsi_init_err0;
	}
=E2=80=A6

How do you think about to move the condition check for the data structure
member =E2=80=9Cfixed_mode=E2=80=9D directly after the corresponding assig=
nment?
Can it be helpful to reorder these statements a bit?

Regards,
Markus
