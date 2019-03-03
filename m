Return-Path: <SRS0=GAfv=RG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9930C43381
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 14:03:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AD7020823
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 14:03:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726347AbfCCODd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 09:03:33 -0500
Received: from www1102.sakura.ne.jp ([219.94.129.142]:44016 "EHLO
        www1102.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726250AbfCCODd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 09:03:33 -0500
Received: from fsav401.sakura.ne.jp (fsav401.sakura.ne.jp [133.242.250.100])
        by www1102.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x23E3Tkc002807;
        Sun, 3 Mar 2019 23:03:30 +0900 (JST)
        (envelope-from katsuhiro@katsuster.net)
Received: from www1102.sakura.ne.jp (219.94.129.142)
 by fsav401.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav401.sakura.ne.jp);
 Sun, 03 Mar 2019 23:03:29 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav401.sakura.ne.jp)
Received: from [192.168.1.2] (119.104.232.153.ap.dti.ne.jp [153.232.104.119])
        (authenticated bits=0)
        by www1102.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x23E3TnS002800
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Sun, 3 Mar 2019 23:03:29 +0900 (JST)
        (envelope-from katsuhiro@katsuster.net)
Subject: Re: [PATCH] arm64: dts: rockchip: decrease rising edge time of UART2
To:     Heiko Stuebner <heiko@sntech.de>,
        Akash Gajjar <Akash_Gajjar@mentor.com>,
        Brian Norris <briannorris@chromium.org>,
        Christoph Muellner <christoph.muellner@theobroma-systems.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Douglas Anderson <dianders@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Jakob Unterwurzacher <jakob.unterwurzacher@theobroma-systems.com>,
        Klaus Goger <klaus.goger@theobroma-systems.com>,
        Levin Du <djw@t-chip.com.cn>,
        Linus Walleij <linus.walleij@linaro.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Matthias Brugger <mbrugger@suse.com>,
        Oskari Lemmela <oskari@lemmela.net>,
        Robin Murphy <robin.murphy@arm.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Shohei Maruyama <cheat.sc.linux@outlook.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Vicente Bergas <vicencb@gmail.com>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20190303122705.27094-1-katsuhiro@katsuster.net>
 <1623469.Hy6pdcMFRX@phil>
From:   Katsuhiro Suzuki <katsuhiro@katsuster.net>
Message-ID: <e722acb4-167f-8333-5c8a-b693815273f4@katsuster.net>
Date:   Sun, 3 Mar 2019 23:03:29 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <1623469.Hy6pdcMFRX@phil>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Heiko,

Thank you for comments.

On 2019/03/03 22:19, Heiko Stuebner wrote:
> Hi,
> 
> Am Sonntag, 3. März 2019, 13:27:05 CET schrieb Katsuhiro Suzuki:
>> This patch increases drive strength of UART2 from 3mA to 12mA for
>> getting more faster rising edge.
>>
>> RockPro64 is using a very high speed rate (1.5Mbps) for UART2. In
>> this setting, a bit width of UART is about 667ns.
>>
>> In my environment (RockPro64 UART2 with FTDI FT232RL UART-USB
>> converter), falling time of RockPro64 UART2 is 40ns, but riging time
>> is over 650ns. So UART receiver will get wrong data, because receiver
>> read intermediate data of rising edge.
>>
>> Rising time becomes 300ns from 650ns if apply this patch. This is not
>> perfect solution but better than now.
>>
>> Signed-off-by: Katsuhiro Suzuki <katsuhiro@katsuster.net>
>> ---
>>   arch/arm64/boot/dts/rockchip/rk3399.dtsi | 9 +++++++--
>>   1 file changed, 7 insertions(+), 2 deletions(-)
> 
> your changing a core rk3399 property here, so I'd really like to get
> input from other board stakeholders on this before applying a core
> change.
> 
> Could you either include the submitters of other rk3399-boards in the
> recipient list so that they're aware or limit the change to rockpro64 for
> the time being (aka overriding the property in the board-dts) please?
> 

OK, I'm adding other boards members.
by ./scripts/get_maintainer.pl arch/arm64/boot/dts/rockchip/rk3399-*.dts


RockPro64 directly connect UART2 pins of RK3399 to external connector.
I think maybe other RK3399 boards are facing same problem, but I cannot
check it because I have RockPro64 only...

I'm happy if someone tell me other boards situation.

Best Regards,
Katsuhiro Suzuki


> Thanks
> Heiko
> 
> 
> 
>> diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
>> index beaa92744a64..e3c8f91ead50 100644
>> --- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
>> +++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
>> @@ -2000,6 +2000,11 @@
>>   			drive-strength = <8>;
>>   		};
>>   
>> +		pcfg_pull_up_12ma: pcfg-pull-up-12ma {
>> +			bias-pull-up;
>> +			drive-strength = <12>;
>> +		};
>> +
>>   		pcfg_pull_up_18ma: pcfg-pull-up-18ma {
>>   			bias-pull-up;
>>   			drive-strength = <18>;
>> @@ -2521,8 +2526,8 @@
>>   		uart2c {
>>   			uart2c_xfer: uart2c-xfer {
>>   				rockchip,pins =
>> -					<4 RK_PC3 RK_FUNC_1 &pcfg_pull_up>,
>> -					<4 RK_PC4 RK_FUNC_1 &pcfg_pull_none>;
>> +					<4 RK_PC3 RK_FUNC_1 &pcfg_pull_up_12ma>,
>> +					<4 RK_PC4 RK_FUNC_1 &pcfg_pull_none_12ma>;
>>   			};
>>   		};
>>   
>>
> 
> 
> 
> 
> 
> 

