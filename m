Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3D69C47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 18:50:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 972DB206C0
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 18:50:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728680AbfJGSuH convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 14:50:07 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:58275 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728079AbfJGSuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 14:50:06 -0400
Received: from mail-pl1-f199.google.com ([209.85.214.199])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1iHY57-0004gK-5r
        for linux-kernel@vger.kernel.org; Mon, 07 Oct 2019 18:50:05 +0000
Received: by mail-pl1-f199.google.com with SMTP id h11so9168752plt.11
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2019 11:50:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=j3n/ZkJyjbkCNJF6jyQHAc6ep3KG8jgIKugTOiAIquA=;
        b=dVs7CiU/7Q7jg5fwl6p8qapqYOoNT+IR3ch6oo+aCe5gnz/Q0BVVX8cgSyAT9So6M5
         PWYa7U+/lXatG07EU5frsnV8S7hZKCptraWs63a2U95wEfFQdeNPMimGXXo4gMfAAk6v
         qZIz78j+vSNt855ypNuyrdW0A4zZB8YJSrS96ig/slfUIbML2jhLDVQtsxaFGWDSkWSL
         tQNUSWiTrkkRr/EWSeXil86NmBnIGx9GHU4fFrgBk4XJW1R34D6DD9ZttZy6Gz4EoK+u
         FFeKo567zAlz9PdeNERAXLVplhIMoa0DFsAVXFDwh7W0652bDTIUbOnH8T1DJL9NIvX8
         Answ==
X-Gm-Message-State: APjAAAVmA+JZv1CnXOhz2k3VOAO4YCabcFFB89dtCOLvmQ/W7UPBtiyE
        zfFTOUg8RBVx7eirqIRiH+E2svumC/kvhUxu25lZUk0m9skHXd93WgljvKExLy4Aj8RsIH/+n2+
        gUOUx/3rJSnBNdNhlDq2cHxhA5zNmf3MChryOlS0Csw==
X-Received: by 2002:a63:cf4a:: with SMTP id b10mr31888983pgj.276.1570474203606;
        Mon, 07 Oct 2019 11:50:03 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxYyjrNHb+/upkDF34lQqoJHpIsoJNhShTHUYsAQiE+4k5gVsln5/4pRkvWxwYkZjhr4KZGLQ==
X-Received: by 2002:a63:cf4a:: with SMTP id b10mr31888961pgj.276.1570474203258;
        Mon, 07 Oct 2019 11:50:03 -0700 (PDT)
Received: from 2001-b011-380f-3c42-ecd4-c98e-b194-f9c1.dynamic-ip6.hinet.net (2001-b011-380f-3c42-ecd4-c98e-b194-f9c1.dynamic-ip6.hinet.net. [2001:b011:380f:3c42:ecd4:c98e:b194:f9c1])
        by smtp.gmail.com with ESMTPSA id ce16sm223338pjb.29.2019.10.07.11.50.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Oct 2019 11:50:02 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3594.4.19\))
Subject: Re: [PATCH v4 2/2] ALSA: hda: Allow HDA to be runtime suspended when
 dGPU is not bound to a driver
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <20190925113255.25062-2-kai.heng.feng@canonical.com>
Date:   Tue, 8 Oct 2019 02:49:56 +0800
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        alsa-devel@alsa-project.org, LKML <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <F3E69B3D-E11B-4D99-905A-CC5927D61D6C@canonical.com>
References: <20190925113255.25062-1-kai.heng.feng@canonical.com>
 <20190925113255.25062-2-kai.heng.feng@canonical.com>
To:     tiwai@suse.com
X-Mailer: Apple Mail (2.3594.4.19)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Takashi,

> On Sep 25, 2019, at 19:32, Kai-Heng Feng <kai.heng.feng@canonical.com> wrote:
> 
> Nvidia proprietary driver doesn't support runtime power management, so
> when a user only wants to use the integrated GPU, it's a common practice
> to let dGPU not to bind any driver, and let its upstream port to be
> runtime suspended. At the end of runtime suspension the port uses
> platform power management to disable power through _OFF method of power
> resource, which is listed by _PR3.
> 
> After commit b516ea586d71 ("PCI: Enable NVIDIA HDA controllers"), when
> the dGPU comes with an HDA function, the HDA won't be suspended if the
> dGPU is unbound, so the power resource can't be turned off by its
> upstream port driver.
> 
> Commit 37a3a98ef601 ("ALSA: hda - Enable runtime PM only for
> discrete GPU") only allows HDA to be runtime suspended once GPU is
> bound, to keep APU's HDA working.
> 
> However, HDA on dGPU isn't that useful if dGPU is not bound to any
> driver.  So let's relax the runtime suspend requirement for dGPU's HDA
> function, to disable the power source to save lots of power.
> 
> BugLink: https://bugs.launchpad.net/bugs/1840835
> Fixes: b516ea586d71 ("PCI: Enable NVIDIA HDA controllers")
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

Do you still have any concern on this patch?
Please merge [v5 1/2] and this patch [v4 2/2] if you think it's good.

Thanks!

Kai-Heng

> ---
> v4:
> - Find upstream port, it's callee's responsibility now.
> v3:
> - Make changelog more clear.
> v2:
> - Change wording.
> - Rebase to Tiwai's branch.
> sound/pci/hda/hda_intel.c | 8 +++++++-
> 1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
> index 240f4ca76391..e63b871343e5 100644
> --- a/sound/pci/hda/hda_intel.c
> +++ b/sound/pci/hda/hda_intel.c
> @@ -1280,11 +1280,17 @@ static void init_vga_switcheroo(struct azx *chip)
> {
> 	struct hda_intel *hda = container_of(chip, struct hda_intel, chip);
> 	struct pci_dev *p = get_bound_vga(chip->pci);
> +	struct pci_dev *parent;
> 	if (p) {
> 		dev_info(chip->card->dev,
> 			 "Handle vga_switcheroo audio client\n");
> 		hda->use_vga_switcheroo = 1;
> -		chip->bus.keep_power = 1; /* cleared in either gpu_bound op or codec probe */
> +
> +		/* cleared in either gpu_bound op or codec probe, or when its
> +		 * upstream port has _PR3 (i.e. dGPU).
> +		 */
> +		parent = pci_upstream_bridge(p);
> +		chip->bus.keep_power = parent ? !pci_pr3_present(parent) : 1;
> 		chip->driver_caps |= AZX_DCAPS_PM_RUNTIME;
> 		pci_dev_put(p);
> 	}
> -- 
> 2.17.1
> 

