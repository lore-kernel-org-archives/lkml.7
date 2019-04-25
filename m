Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D70DC43218
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 17:47:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA2E320678
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 17:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556214442;
	bh=AUdoWhVPFdpf0v08LNNF6iat4QJhjIZKjC33Kb6Z93g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Dk6Y+mkIHoQtoKBcRQ6tY1TrWqsDJ9oFarwrWddyBEjYGU7lBCHuhAY440gsjo1mY
	 XY5d0GtDSv/1nGvSyQ27VDJTdB3Oou36rckF4Z5VXX8/+4m7e4/xcYTa0E0HCBoK72
	 Dm41E2euy1B3Bnvh68yeuAT6RGuxIk/Fs9PT9tDk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729963AbfDYRrU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 13:47:20 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40294 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725937AbfDYRrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 13:47:20 -0400
Received: by mail-wr1-f66.google.com with SMTP id h4so568815wre.7
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 10:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=y/dP5LTF2ty0scgUvn1G9Vn2NQbE6mKVAGZ7otjunzk=;
        b=c3RvlGY7+vcjtyxXbaLRerZaEh86qA4DX07UFa/ILl1DpJwsYOmG6cWAHNd16OJaZF
         YNqhBwUM1L3TM6WEfptG5ULBMKv8GB4EA0Fdtyebd+au+ip2rmM2kh9vKGoHYcfA0JZG
         qPyLvFuz3hiwe4uZHpndKzayNFHoQ8GiuISvbTAkj/m/Fst8ls4kZv7I66os7VLONf9k
         DKzCW1rnmO2Kb3Vf0oFYjdptPfpDhNybQrXKLaDHEJuJ4W1EFps9mwAiVt0UGekiUL80
         QjTURQSxCPr1MC2FLnEiCJ2swkxsCeAGsIRpphHI++ARG3cT57itsvbumaE1wVQC0sd3
         UGgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=y/dP5LTF2ty0scgUvn1G9Vn2NQbE6mKVAGZ7otjunzk=;
        b=lWJkH9aM4gzmDKGkLo5hWS5xcy6qrAhV4oOc/hEMMB/uPkFRfDNACcznuUFnsdNKOU
         HKSxFPCklKmwITqGJyf375X/1ia2LG/xnJgHgid5D9Gmdz3zKOQN40herjcW9T6sPVL8
         q3oB44vnw5wIysLPVGpbB7PJQ17BBogii03cXNrHJpSyfedf7UZFsOjD5/be6CIbxdke
         t48vARBTo4hBYZO791+8IsRyWxwNIWnUnQPkorNoO1Aj6MuMGpyfiB02zFcyfkxU/ED6
         NW9aCSeQS+lRjtqGp2WIl7boq32ZsHgJuHF1SWKutxX9Oe8/D23P4q7SmYuEUYh6jADY
         ZNmg==
X-Gm-Message-State: APjAAAVtVPZxyNK8QYWuWAsiJ/bhowZr3boHTvHrc9eMwHLBXmNZDbjm
        2E/f2fuWTBfVTxIuFIGFIBA=
X-Google-Smtp-Source: APXvYqx6NOc/Cp2wFd/u/zj10nTjersqwHCx31tDrmJWpxhfJ7U+FTXDA6ID/+LWVnjFA8cL12oKUw==
X-Received: by 2002:a5d:550b:: with SMTP id b11mr12094568wrv.81.1556214438135;
        Thu, 25 Apr 2019 10:47:18 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id z4sm850990wrq.75.2019.04.25.10.47.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Apr 2019 10:47:17 -0700 (PDT)
Date:   Thu, 25 Apr 2019 19:47:15 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     acme@redhat.com, mingo@redhat.com, linux-kernel@vger.kernel.org,
        jolsa@redhat.com, namhyung@gmail.com, lgoncalv@redhat.com,
        ak@linux.intel.com
Subject: Re: [PATCH] perf stat: Add hint for SMI cost measurement
Message-ID: <20190425174715.GA61828@gmail.com>
References: <1556120792-35415-1-git-send-email-kan.liang@linux.intel.com>
 <20190425063910.GA85646@gmail.com>
 <9beeb53a-39ef-7e60-34b7-e2cfbe355a0e@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9beeb53a-39ef-7e60-34b7-e2cfbe355a0e@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Liang, Kan <kan.liang@linux.intel.com> wrote:

> 
> 
> On 4/25/2019 2:39 AM, Ingo Molnar wrote:
> > 
> > * kan.liang@linux.intel.com <kan.liang@linux.intel.com> wrote:
> > 
> > > +static void smi_env_check(void)
> > > +{
> > > +	char *name;
> > > +	size_t len;
> > > +
> > > +	if (sysfs__read_str(CPUIDLE_CUR_DRV, &name, &len)) {
> > > +		pr_warning("Failed to check cstate status.\n");
> > 
> > What a meaningless message. What did we want to do, what happened, and
> > why did it fail?
> > 
> > > +		return;
> > > +	}
> > > +
> > > +	if (strncmp(name, "none", 4)) {
> > > +		pr_warning("Cstate may cause drift between aperf and cycles. "
> > > +			   "Please completely disable cstate, "
> > > +			   "E.g. set idle=poll in grub\n");
> > 
> > Please keep user-visible strings in the same form that the user sees
> > them, i.e. in a single line.
> 
> To avoid the line over 80 characters, the quoted string was split across
> lines in the code. But the string is shown as a single line when it is
> output for user.
> 
> Are you suggesting to ignore the 80 characters rule when printing
> user-visible strings?
> Could you please confirm?

What I'd suggest is split it up into multiple messages, or shorten the 
message. Small violations of col80 for user visible strings is fine (up 
to 100-120 columns I guess), but if the string is longer it's a clear 
sign that the syslog message it too long to begin ...

Thanks,

	Ingo
