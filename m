Return-Path: <SRS0=OfNL=RF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E84AC43381
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 13:00:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1EE620838
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 13:00:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z4bIadvP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbfCBNAE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Mar 2019 08:00:04 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42298 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726049AbfCBNAE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Mar 2019 08:00:04 -0500
Received: by mail-pg1-f196.google.com with SMTP id b2so323676pgl.9
        for <linux-kernel@vger.kernel.org>; Sat, 02 Mar 2019 05:00:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/wTns5QPuDo+J1NyvXOlmOIqmrL7mvCVtWAYA/U/wJM=;
        b=Z4bIadvPW/HuFXuCIpvqWYj/A3riHF0fv21vsBYp3NBjT6VRHx3JtYkpTLYHjy6vkc
         CISJmoM8QPWBUq+OrPX55pKmf9JfzFywLWcV8ToODMuRMvD9UWcldkEsDaT1CZpqUqix
         h2OjDzQsjq46Uj2HCi+9JTT3yhK6Eozo/TWDBU/EP7CK45/hE+mjgAgof1CTtXNwc0ns
         8uBdvGT1FfZDEVbirjJ+cewF1WyLbrIdmqrH7++N/X5eOtWZklh9PTRiX0bd51fe9v1D
         FgKlBnalUiNJlo/0cg2oSODh0ysF/rFPHEr4aZpBdnHn10BDwwLhiAEb28cv1zrCaDQq
         fL7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/wTns5QPuDo+J1NyvXOlmOIqmrL7mvCVtWAYA/U/wJM=;
        b=mQl7BFfs+2aIExJ4vT77y5SsnqSMk7EMe8tx54XN6rgk9hL8H+fjgPGV3HrKmXj/Mr
         boClsDowx3z1GjUkp1BOXswdPHzE/qle46lWEkVchfhFTzmhWx5tbI9r7azhDSyndQpv
         Pk5AuuucbKaaxcx9qvAPmzYPOocJv1HjkQamLVu0YYByLCh9GlrRlEj83pU1PFi4EImO
         SiyKSrFcuz7BpFHk/ZQ7y20qTXTC7j0fMK7PbjTH6S4y7NVE9B3nI583SD8hYM0bOE7V
         NNXyOBQN4LaSfuuua6Wwy/lSzKcH/xIphp7+7SAEZJs897GBkl7wMQqkJo+SShQomCzM
         iamw==
X-Gm-Message-State: APjAAAVtaIf8FrDyYqvJgSFpTuZ70EnR0WNn8+tqiFleU5nuNcBLgTUq
        d6wldQ/lwW8Yj8HzIWODpfJUKg==
X-Google-Smtp-Source: APXvYqymuon4VNkVPFWuNwbmk7MVQPD959f3S92mw0Vf2eh0xC/Rr6R9tB5lEH7pjWnNEZcsEA+Gjw==
X-Received: by 2002:a63:2b03:: with SMTP id r3mr9389634pgr.1.1551531602937;
        Sat, 02 Mar 2019 05:00:02 -0800 (PST)
Received: from leoy-ThinkPad-X240s (li1206-191.members.linode.com. [45.79.107.191])
        by smtp.gmail.com with ESMTPSA id z77sm1492048pfi.155.2019.03.02.04.59.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 02 Mar 2019 05:00:01 -0800 (PST)
Date:   Sat, 2 Mar 2019 20:59:55 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Shiwanglai <shiwanglai@hisilicon.com>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "john.stultz@linaro.org" <john.stultz@linaro.org>,
        "xuwei (O)" <xuwei5@huawei.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "coresight@lists.linaro.org" <coresight@lists.linaro.org>,
        Suzhuangluan <suzhuangluan@hisilicon.com>
Subject: Re: [PATCH v2] dts: arm64: add CoreSight trace support for hi3660
Message-ID: <20190302125955.GA11385@leoy-ThinkPad-X240s>
References: <6496F4728C09F6479CFF21A8E67D33D568F32660@dggema525-mbx.china.huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6496F4728C09F6479CFF21A8E67D33D568F32660@dggema525-mbx.china.huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 02, 2019 at 09:45:22AM +0000, Shiwanglai wrote:

[...]

> > +		/* Top internals */
> > +		funnel@ec031000 {
> > +			compatible = "arm,coresight-funnel", "arm,primecell";
> > +			reg = <0 0xec031000 0 0x1000>;
> > +			clocks = <&crg_ctrl HI3660_PCLK>;
> > +			clock-names = "apb_pclk";
> > +
> > +			out-ports {
> > +				port {
> > +					top_funnel_out: endpoint {
> > +						remote-endpoint =
> > +							<&top_etf_in>;
> > +					};
> > +				};
> > +			};
> > +
> > +			in-ports {
> > +				#address-cells = <1>;
> > +				#size-cells = <0>;
> > +
> > +				port@0 {
> > +					reg = <0>;
> > +					top_funnel_in0: endpoint {
> > +						remote-endpoint =
> > +							<&cluster0_etf_out>;
> > +					};
> > +				};
> > +
> > +				port@1 {
> > +					reg = <0>;
> 
> Here should s/<0>/<1>; otherwise DTC will complain warning for mismatching between 'port@1' and 'reg = <0>'.

> -- if reg set to 1, then there's no data output from cluster 1 to top.

Thanks for the info, Wanglai.  Now I see why write as it is.

I can confirm if directly use your patch with perf with mainline
kernel I can capture CoreSight trace data successfully on Hikey960
board.

But since this DT binding will introduce DTC warning, I personally
think we can improve for this with below method:

We can create a funnel node named "funnel_combo", and we don't need to
specify register address range for it; and cluster 0 and cluster 1 will
output to "funnel_combo" and "funnel_combo" will output to the top
funnel.  Thus the DT binding will write as below.

To support for a funnel without any register address range (we have
support replicator like this mode), we also need to extend the driver
drivers/hwtracing/coresight/coresight-funnel.c.

Mathieu, Mike, Suzuki, could you help confirm this is the right
direction we should move forward to?

---8<---
	/* An invisible combo funnel between clusters and top funnel */
	funnel_combo {
		compatible = "arm,coresight-funnel";
		clocks = <&crg_ctrl HI3660_PCLK>;
		clock-names = "apb_pclk";

		out-ports {
			port {
				combo_funnel_out: endpoint {
					remote-endpoint =
						<&top_funnel_in>;
				};
			};
		};

		in-ports {
			#address-cells = <1>;
			#size-cells = <0>;

			port@0 {
				reg = <0>;
				combo_funnel_in0: endpoint {
					remote-endpoint =
						<&cluster0_etf_out>;
				};
			};

			port@1 {
				reg = <1>;
				combo_funnel_in1: endpoint {
					remote-endpoint =
						<&cluster1_etf_out>;
				};
			};
		};
	};

	/* Top internals */
	funnel@ec031000 {
		compatible = "arm,coresight-funnel", "arm,primecell";
		reg = <0 0xec031000 0 0x1000>;
		clocks = <&crg_ctrl HI3660_PCLK>;
		clock-names = "apb_pclk";

		out-ports {
			port {
				top_funnel_out: endpoint {
					remote-endpoint =
						<&top_etf_in>;
				};
			};
		};

		in-ports {
			#address-cells = <1>;
			#size-cells = <0>;

			port@0 {
				reg = <0>;
				top_funnel_in: endpoint {
					remote-endpoint =
						<&combo_funnel_out>;
				};
			};
		};
	};

--->8---

[...]

Thanks,
Leo Yan
