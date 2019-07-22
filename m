Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A307C76194
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 19:46:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4152D218B0
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 19:46:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="GOl+n50o";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ERr2t9Tz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732321AbfGVTq1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 15:46:27 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:39782 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728728AbfGVTq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 15:46:27 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id F15B960F3E; Mon, 22 Jul 2019 19:46:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1563824786;
        bh=7eD+eVqFrtz3xwFVMMyatV/ixJ3r8Kbtxeq9wzu5IKQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GOl+n50oNJeKGpt1Z0Psg6IsQpupO2+uH9JxXDplcwwpU+dSKAJAmcg+8J3jGxpq5
         qf1rHJQ3vBKSAIu45h5jk6LpUa070gZ6UF7xRH/U5v8uOjyfiZztRuGZmf5BH5NS3Z
         DhVuipozaH1XgVVBX02F7knbBYhbfRQuML0OyNOs=
Received: from localhost (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: ilina@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1808460E72;
        Mon, 22 Jul 2019 19:46:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1563824785;
        bh=7eD+eVqFrtz3xwFVMMyatV/ixJ3r8Kbtxeq9wzu5IKQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ERr2t9TzgA7dmFYQp6vEONA9i9/l5p8TslDfJQXB+JVAmLHefAc6cSxX7TYP2fcJD
         +URQ4J+SrDUSabnJqEPXVI0x90iUETo84prVGXQIJYcVbXNO/6qe1IUaxJGpEMYxV8
         uxKnXuhGMVwRqMziIXCugnf7xhWEK0byf4+wjnTs=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1808460E72
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
Date:   Mon, 22 Jul 2019 13:46:24 -0600
From:   Lina Iyer <ilina@codeaurora.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     andy.gross@linaro.org, bjorn.andersson@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        rnayak@codeaurora.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, dianders@chromium.org,
        mkshah@codeaurora.org, "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>
Subject: Re: [PATCH 1/2] drivers: qcom: rpmh-rsc: simplify TCS locking
Message-ID: <20190722194624.GA11589@codeaurora.org>
References: <20190701152907.16407-1-ilina@codeaurora.org>
 <5d3209e7.1c69fb81.5ef1.5195@mx.google.com>
 <20190722162003.GG25567@codeaurora.org>
 <5d35fdfb.1c69fb81.5fafa.aaa9@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <5d35fdfb.1c69fb81.5fafa.aaa9@mx.google.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 22 2019 at 12:18 -0600, Stephen Boyd wrote:
>Quoting Lina Iyer (2019-07-22 09:20:03)
>> On Fri, Jul 19 2019 at 12:20 -0600, Stephen Boyd wrote:
>> >Quoting Lina Iyer (2019-07-01 08:29:06)
>> >> From: "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>
>> >>
>> >> tcs->lock was introduced to serialize access with in TCS group. But
>> >> even without tcs->lock, drv->lock is serving the same purpose. So
>> >> use a single drv->lock.
>> >
>> >Isn't the downside now that we're going to be serializing access to the
>> >different TCSes when two are being written in parallel or waited on? I
>> >thought that was the whole point of splitting the lock into a TCS lock
>> >and a general "driver" lock that protects the global driver state vs.
>> >the specific TCS state.
>> >
>> Yes but we were holding the drv->lock as well as tcs->lock for the most
>> critical of the path anyways (writing to TCS). The added complexity
>> doesn't seem to help reduce the latency that it expected to reduce.
>
>Ok. That sort of information should be in the commit text to explain why
>it's not helping with reducing the latency or throughput of the API.
>
Will add.

--Lina
