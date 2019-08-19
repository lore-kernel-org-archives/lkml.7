Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02076C3A59D
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 12:06:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC1742085A
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 12:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566216408;
	bh=n6lQ+lfW9tVYMdnFOWqkZvUfLjEDOHodohIWRDFkVfU=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=sJ8eFva/864lBDqVSfFrJ62gRIlaF7CsTMcG3upKkCwExeB0ux7ppedNfghRdM60L
	 eqJzOh7DYvOk+8oGX5tL9jSfQkNTjKV1x4j6wmXEBgVzxjXgSKF5aHaJShC9oWd2UN
	 cRjGm1fJS1ghlYc4qjuA9tMLL3j2ECPAezM7GYo4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727252AbfHSMGr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 08:06:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:46560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726491AbfHSMGr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 08:06:47 -0400
Received: from pobox.suse.cz (prg-ext-pat.suse.com [213.151.95.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B8E452085A;
        Mon, 19 Aug 2019 12:06:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566216406;
        bh=n6lQ+lfW9tVYMdnFOWqkZvUfLjEDOHodohIWRDFkVfU=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=nsH6jx9vYorr0bZVMf/IZKDn7xobb5cd6jGG8Sq+5LOIodbtjM1glja6VlPJ/KOgg
         HvD/8lKYMzGio4I0jRpBVMG3AZoK0N8HWFZeAFNNNQvio7daa5n5qAkKq+QXXrD0hz
         MK+Vum//gVxFfYaKm1fdOtq+TKbYCQ51PFK9Nm4k=
Date:   Mon, 19 Aug 2019 14:06:37 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Zhang Lixu <lixu.zhang@intel.com>
cc:     linux-input@vger.kernel.org, benjamin.tissoires@redhat.com,
        srinivas.pandruvada@linux.intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] HID: intel-ish-hid: support s2idle and s3 in
 ish_suspend()
In-Reply-To: <20190808102113.27802-1-lixu.zhang@intel.com>
Message-ID: <nycvar.YFH.7.76.1908191406250.27147@cbobk.fhfr.pm>
References: <20190808102113.27802-1-lixu.zhang@intel.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Aug 2019, Zhang Lixu wrote:

> Currently, the NO_D3 flag is set in ish_probe(), the intel-ish-ipc driver
> puts the ISH into D0i3 when system enter both suspend-to-idle(S0ix) and
> suspend-to-mem(S3). These patches are to put the ISH into D3 when system
> enter S3 and put the ISH into D0i3 when system enter S0ix.
> 
> I tested these patches on the following platforms:
> ISH 5.2: ICL
> ISH 5.0: CNL CFL WHL CML
> ISH 4.0: GLK
> ISH 3.0: KBL
> 
> Test steps:
> * Run the IIO Sensor tool to read the accel_3d sensor data
> * Run cmd "echo mem > /sys/power/state" to suspend-to-mem
> * Press the keyboard to wake up OS.
> * Check if the tool can get the sensor data after OS resume.
> * Run cmd "echo freeze > /sys/power/state" to suspend-to-idle
> * Press the keyboard to wake up OS.
> * Check if the tool can get the sensor data after OS resume.
> 
> Test results:
> The tool can get the accel_3d sensor data after resuming from both
> suspend-to-mem and suspend-to-idle.
> 
> Changes from v1:
> * Fix the indentation issue
> * Elaborate the reason to remove the NO_D3 flag
> * Split the PATCH v1 to three changes, and try to minimize the lines change

Applied to for-5.4/ish. Thanks,

-- 
Jiri Kosina
SUSE Labs

