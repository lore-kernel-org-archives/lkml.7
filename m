Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 468D0C06510
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 14:57:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 063FC21479
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 14:57:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="B2ypATqy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727053AbfGBO5S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 10:57:18 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:49504 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725981AbfGBO5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 10:57:18 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x62Erf5J017648;
        Tue, 2 Jul 2019 16:57:05 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=NUbU5Q6yEBQUCStYjxBrt6KQ8QWKe6FhU2+NRmbzbiQ=;
 b=B2ypATqyrYb6oUh0fO7hB0NcUeGrJtmOvACzS8I4UN8OK/Rlqar2Q/lYpvB7i3ejFeoN
 2MIB0fNV4gOIHZkDwRNJAEfdN4ZlMRGNwlMo8tkemA4qL7JDM9o2EJBWzjSwNbJItDWw
 l1RrdA2g/EIbzPt9ypsT66mH7heTdxa/mV6dw9ctgCXq+pFTPTWyDVeGPvZSiibAmeqM
 6jnQ2IPgd4533dQXSjU3ST8QZeeoA4X2lZyQ9QijBxZztGkRdT2zINHgS8fA2NFYyOns
 w+KIS9TyqjMBBo3Vg5VF4oAw1sFndBJYMRrqbj2K9vBeKl4159SU3LHP5PVqxZ05WmS+ Hg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2tdxvhvrdy-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 02 Jul 2019 16:57:05 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 8A1D131;
        Tue,  2 Jul 2019 14:56:57 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node1.st.com [10.75.127.7])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 5844C2CA0;
        Tue,  2 Jul 2019 14:56:57 +0000 (GMT)
Received: from [10.48.0.131] (10.75.127.51) by SFHDAG3NODE1.st.com
 (10.75.127.7) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue, 2 Jul
 2019 16:56:56 +0200
Subject: Re: [PATCH v2 2/2] tty: add rpmsg driver
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
CC:     Ohad Ben-Cohen <ohad@wizery.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        xiang xiao <xiaoxiang781216@gmail.com>,
        <linux-kernel@vger.kernel.org>, <linux-remoteproc@vger.kernel.org>,
        Fabien DESSENNE <fabien.dessenne@st.com>
References: <1557500577-22366-1-git-send-email-arnaud.pouliquen@st.com>
 <1557500577-22366-3-git-send-email-arnaud.pouliquen@st.com>
 <20190701060039.GD1263@builder>
From:   Arnaud Pouliquen <arnaud.pouliquen@st.com>
Openpgp: preference=signencrypt
Autocrypt: addr=arnaud.pouliquen@st.com; prefer-encrypt=mutual; keydata=
 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
 8mOik8I/F6EW8XyQAA2P
Message-ID: <ed383111-01f7-21ac-4ec5-de80776394a4@st.com>
Date:   Tue, 2 Jul 2019 16:56:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190701060039.GD1263@builder>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.75.127.51]
X-ClientProxiedBy: SFHDAG2NODE1.st.com (10.75.127.4) To SFHDAG3NODE1.st.com
 (10.75.127.7)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-02_08:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,

On 7/1/19 8:00 AM, Bjorn Andersson wrote:
> On Fri 10 May 08:02 PDT 2019, Arnaud Pouliquen wrote:
> 
>> This driver exposes a standard tty interface on top of the rpmsg
>> framework through the "rpmsg-tty-channel" rpmsg service.
>>
>> This driver supports multi-instances, offering a /dev/ttyRPMSGx entry
>> per rpmsg endpoint.
>>
>> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
>> Signed-off-by: Fabien Dessenne <fabien.dessenne@st.com>
>> ---
>>  Documentation/serial/tty_rpmsg.txt |  38 +++
>>  drivers/tty/Kconfig                |   9 +
>>  drivers/tty/Makefile               |   1 +
>>  drivers/tty/rpmsg_tty.c            | 479 +++++++++++++++++++++++++++++++++++++
>>  4 files changed, 527 insertions(+)
>>  create mode 100644 Documentation/serial/tty_rpmsg.txt
>>  create mode 100644 drivers/tty/rpmsg_tty.c
>>
>> diff --git a/Documentation/serial/tty_rpmsg.txt b/Documentation/serial/tty_rpmsg.txt
>> new file mode 100644
>> index 000000000000..e069ed268a2b
>> --- /dev/null
>> +++ b/Documentation/serial/tty_rpmsg.txt
>> @@ -0,0 +1,38 @@
>> +
>> +			The rpmsg TTY
>> +
>> +The rpmsg tty driver implements a serial communication on the rpmsg bus,
>> +to communicate with a remote processor devices in asymmetric multiprocessing
>> +(AMP) configurations.
>> +
>> +The remote processor can instantiate a new tty by requesting a new "rpmsg-tty-channel" RPMsg service. Information related to the RPMsg and
>> +associated tty device is available in /sys/bus/rpmsg/devices/virtio0.rpmsg-tty-channel.-1.<X>, with
>> +<X> corresponding to the ttyRPMSG instance.
>> +
>> +RPMsg data/control structure
>> +----------------------------
>> +
>> +The RPMsg is used to send data or control messages. Differentiation between the
>> +stream and the control messages is done thanks to the first byte of the
>> +RPMsg payload:
>> +
>> +
>> +RPMSG_DATA	- rest of messages contains data
>> +
>> +RPMSG_CTRL 	- message contains control.
>> +
>> +
>> +To be compliant with this driver, the remote firmware has to respect this RPMsg
>> +payload structure. At least the RPMSG_DATA type has to be supported. The
>> +RPMSG_CTRL is optional.
>> +
> 
> This scheme prevents us from using this driver to expose any existing
> tty-like channels without having to modify such firmware.

An alternative could be to define a channel for the control and another
for the data. This would avoid to reserved the first bytes for message type.

> 
>> +Flow control type
>> +-----------------
>> +
>> +A minimum flow control can be implemented to allow/block communication with the remote processor.
>> +
>> +DATA_TERM_READY	-	one parameter:
>> +			- u8 state
>> +				Set to indicate to remote side that terminal is
>> +				ready for communication.
>> +				Reset to block communication with remote side.
> 
> And as shown in discussions following Qualcomm's proposed flow-control
> addition to the rpmsg API the need for flow control is not limited to
> this custom tty like interface

Yes i remember discussions around the flow control, how to set
priorities, bandwidth, etc...
Did you start something on Qualcomm side to support flow control?

RPMsg flow control would also impact the remote side (a.e. OpenAMP).
This subject can be quite extensive, so perhaps, it should be better to
treat it in a separate thread to be sure that design integrate all
requirements.

What about integrating rpmsg tty in a first step (with flow control in
rpmsg tty)? Then in a second step, adapt it on the rpmsg flow control,
and so use it to validate the feature.
This would avoid to block the rpmsg_tty integration... As you mention
seems that several companies have already their own rpmsg tty
implementation...

> 
> 
> So I really would like to see an implementation of a side-band flow
> control mechanism in the virtio rpmsg bus.
> 
>> diff --git a/drivers/tty/Kconfig b/drivers/tty/Kconfig
>> index e0a04bfc873e..d7b426939f69 100644
>> --- a/drivers/tty/Kconfig
>> +++ b/drivers/tty/Kconfig
>> @@ -442,6 +442,15 @@ config VCC
>>  	help
>>  	  Support for Sun logical domain consoles.
>>  
>> +config RPMSG_TTY
>> +	tristate "RPMSG tty driver"
>> +	depends on RPMSG
>> +	help
>> +	  Say y here to export rpmsg endpoints as tty devices, usually found
>> +	  in /dev/ttyRPMSGx.
>> +	  This makes it possible for user-space programs to send and receive
>> +	  rpmsg messages as a standard tty protocol.
>> +
>>  config LDISC_AUTOLOAD
>>  	bool "Automatically load TTY Line Disciplines"
>>  	default y
>> diff --git a/drivers/tty/Makefile b/drivers/tty/Makefile
>> index c72cafdf32b4..90a98a20714d 100644
>> --- a/drivers/tty/Makefile
>> +++ b/drivers/tty/Makefile
>> @@ -33,5 +33,6 @@ obj-$(CONFIG_PPC_EPAPR_HV_BYTECHAN) += ehv_bytechan.o
>>  obj-$(CONFIG_GOLDFISH_TTY)	+= goldfish.o
>>  obj-$(CONFIG_MIPS_EJTAG_FDC_TTY) += mips_ejtag_fdc.o
>>  obj-$(CONFIG_VCC)		+= vcc.o
>> +obj-$(CONFIG_RPMSG_TTY)		+= rpmsg_tty.o
>>  
>>  obj-y += ipwireless/
>> diff --git a/drivers/tty/rpmsg_tty.c b/drivers/tty/rpmsg_tty.c
> [..]
>> +static struct rpmsg_device_id rpmsg_driver_tty_id_table[] = {
>> +	{ .name	= "rpmsg-tty-channel" },
> 
> I really would like a mechanism that does not depend on a fixed channel
> name, as this required that firmware is written specifically for being
> paired with this driver.
> 
> In other words this is exactly the same problem that we worked around in
> rpmsg_charTo be sure... What you propose here is to implement an attribute for the
channel (as rpmsg_eptdevd defined in rpmsg_char), allowing application
could define the channel name?

This point is similar to the one we discussed with Xiang. What should we
consider: the tty service associated to a tty channel or the service on
top of the tty which would be in this case based on rpmsg?

I considered that the service is the tty, as we create a /dev/tty when
service is requested by the remoteproc firmware, so that the service
name is fixed in consequence.

Using attribute for channel name would mean that user registers a
service that will be on top of a tty. In this case, is the TTY is the
good communication channel? why not directly use rpmsg_char?

So perhaps could be better to extend the rpmsg char device for this kind
of requirement, allowing to probe it without associate it to an existing
rpmsg device...?

Thank,
Arnaud

> 
> Regards,
> Bjorn
> 
