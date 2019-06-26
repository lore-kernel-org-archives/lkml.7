Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A485C48BD3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 12:09:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAAEF20B1F
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 12:09:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561550967;
	bh=PxyK9oY0MEgJeIOucTmXIUhsIguCSExshywKlXMEEuY=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=EPPh1VN+9IzLaxo6tBGP4xfNADBhGXVrzhf13rBjQp5AhjkaCJevBFlD4xXR+pUfp
	 ngmXfeHC31+4p+TeFLg3eZGFHXbjbyo1rWFA2uUcbWV+qZXbt82NGIMhsXX//PQ6Hl
	 D+C08xuGei3crK59xEdW0HeotWdlJ+Kc2zZDMu6Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727353AbfFZMJ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 08:09:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:49970 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726131AbfFZMJ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 08:09:26 -0400
Received: from pobox.suse.cz (prg-ext-pat.suse.com [213.151.95.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BE0BE20656;
        Wed, 26 Jun 2019 12:09:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561550965;
        bh=PxyK9oY0MEgJeIOucTmXIUhsIguCSExshywKlXMEEuY=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=sZPAt9mZthZ+DFBoEYSPo3nfWqaDlKDAo5s27r08IaEHsdWCuKigbyO3krlDZxBPN
         FpbPjl2ZwX4mcYt/DsAJqtrozsdw8POlxjzf5/QWqldZYMeF7Czla5CsSdEqh5QR+i
         BIOo+FyXHDE9LEt0JUlz/QSsFQcGbjMmhTkjEHFA=
Date:   Wed, 26 Jun 2019 14:09:21 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
cc:     benjamin.tissoires@redhat.com, even.xu@intel.com,
        hyungwoo.yang@intel.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [UPDATE][PATCH v4] HID: intel-ish-hid: fix wrong driver_data
 usage
In-Reply-To: <20190606045227.7515-1-srinivas.pandruvada@linux.intel.com>
Message-ID: <nycvar.YFH.7.76.1906261409130.27227@cbobk.fhfr.pm>
References: <20190606045227.7515-1-srinivas.pandruvada@linux.intel.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Jun 2019, Srinivas Pandruvada wrote:

> From: Hyungwoo Yang <hyungwoo.yang@intel.com>
> 
> Currently, in suspend() and resume(), ishtp client drivers are using
> driver_data to get "struct ishtp_cl_device" object which is set by
> bus driver. It's wrong since the driver_data should not be owned bus.
> driver_data should be owned by the corresponding ishtp client driver.
> Due to this, some ishtp client driver like cros_ec_ishtp which uses
> its driver_data to transfer its data to its child doesn't work correctly.
> 
> So this patch removes setting driver_data in bus drier and instead of
> using driver_data to get "struct ishtp_cl_device", since "struct device"
> is embedded in "struct ishtp_cl_device", we introduce a helper function
> that returns "struct ishtp_cl_device" from "struct device".
> 
> Signed-off-by: Hyungwoo Yang <hyungwoo.yang@intel.com>
> Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Applied to for-5.2/fixes.

-- 
Jiri Kosina
SUSE Labs

