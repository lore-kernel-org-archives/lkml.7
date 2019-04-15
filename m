Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B720C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 11:23:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 523EB2073F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 11:23:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555327400;
	bh=TOsxNDNb4tufRLm0bSvz5mHfP+hx6oEAUOc7J13dQ6E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=hhy3lJPts6TfmYvNYobAEt1zVEIFRE5sQ9vu66IOIQjCOvuSq/vDU2hJtZ3jDUGQ7
	 pXDF+06w+8oqhGxZPPgsRWT/emVorhUg4S5c1MdFB48w+zhj0WuZT4Bv7ZUtYCla/b
	 poifsg8NijRE1UHegkH4lEaBaLlygRR/CQ5opfoI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727212AbfDOLXS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 07:23:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:39274 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726034AbfDOLXS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 07:23:18 -0400
Received: from linux-8ccs (ip5f5adbb4.dynamic.kabel-deutschland.de [95.90.219.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D460A2073F;
        Mon, 15 Apr 2019 11:23:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555327397;
        bh=TOsxNDNb4tufRLm0bSvz5mHfP+hx6oEAUOc7J13dQ6E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XjDjCatQXhdeiib8jtliErHparazKgKQyWr8sQa/XvzIa01zFus3BC5HbpnlVFpPI
         1HD6w75cL8hu76TWH06xCcB9RRdAO/N0hocuPGgvBkNCg32DpS52G9nyi5xGuO/MyM
         64Z0s8fHzZ3FyLfRfnktGWwkGtUDkWwFO5Z3CCKY=
Date:   Mon, 15 Apr 2019 13:23:13 +0200
From:   Jessica Yu <jeyu@kernel.org>
To:     Prarit Bhargava <prarit@redhat.com>
Cc:     linux-kernel@vger.kernel.org, cavery@redhat.com
Subject: Re: [PATCH] modules: Only return -EEXIST for modules that have
 finished loading
Message-ID: <20190415112313.GA4080@linux-8ccs>
References: <20190402133916.13513-1-prarit@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190402133916.13513-1-prarit@redhat.com>
X-OS:   Linux linux-8ccs 5.1.0-rc1-lp150.12.28-default+ x86_64
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ Prarit Bhargava [02/04/19 09:39 -0400]:
>Microsoft HyperV disables the X86_FEATURE_SMCA bit on AMD systems, and
>linux guests boot with repeated errors:
>
>amd64_edac_mod: Unknown symbol amd_unregister_ecc_decoder (err -2)
>amd64_edac_mod: Unknown symbol amd_register_ecc_decoder (err -2)
>amd64_edac_mod: Unknown symbol amd_report_gart_errors (err -2)
>amd64_edac_mod: Unknown symbol amd_unregister_ecc_decoder (err -2)
>amd64_edac_mod: Unknown symbol amd_register_ecc_decoder (err -2)
>amd64_edac_mod: Unknown symbol amd_report_gart_errors (err -2)
>
>The warnings occur because the module code erroneously returns -EEXIST
>for modules that have failed to load and are in the process of being
>removed from the module list.
>
>module amd64_edac_mod has a dependency on module edac_mce_amd.  Using
>modules.dep, systemd will load edac_mce_amd for every request of
>amd64_edac_mod.  When the edac_mce_amd module loads, the module has
>state MODULE_STATE_UNFORMED and once the module load fails and the state
>becomes MODULE_STATE_GOING.  Another request for edac_mce_amd module
>executes and add_unformed_module() will erroneously return -EEXIST even
>though the previous instance of edac_mce_amd has MODULE_STATE_GOING.
>Upon receiving -EEXIST, systemd attempts to load amd64_edac_mod, which
>fails because of unknown symbols from edac_mce_amd.
>
>add_unformed_module() must wait to return for any case other than
>MODULE_STATE_LIVE to prevent a race between multiple loads of
>dependent modules.
>
>Signed-off-by: Prarit Bhargava <prarit@redhat.com>
>Reported-by: Cathy Avery <cavery@redhat.com>
>Cc: Jessica Yu <jeyu@kernel.org>

Applied to modules-next. Thanks Prarit!

Jessica

