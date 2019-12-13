Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 927B3C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 07:41:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51120214D8
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 07:41:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725991AbfLMHlG convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 02:41:06 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:38341 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725468AbfLMHlF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 02:41:05 -0500
Received: from marcel-macbook.fritz.box (p4FF9F0D1.dip0.t-ipconnect.de [79.249.240.209])
        by mail.holtmann.org (Postfix) with ESMTPSA id EDC35CECF0;
        Fri, 13 Dec 2019 08:50:14 +0100 (CET)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.40.2.2.4\))
Subject: Re: [PATCH v1 1/2] Bluetooth: hci_qca: Add support for Qualcomm
 Bluetooth SoC QCA6390
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <471977a5037f06093945c5e71c78e538@codeaurora.org>
Date:   Fri, 13 Dec 2019 08:41:03 +0100
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        lkml <linux-kernel@vger.kernel.org>,
        linux-bluetooth@vger.kernel.org,
        linux-bluetooth-owner@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <E84B037B-C0C2-4890-A4BD-94BECC074E59@holtmann.org>
References: <0101016ef8b72eb9-c2212883-72cf-4f02-9f5d-078135c7085e-000000@us-west-2.amazonses.com>
 <34736FC9-23E5-4C6D-AFDC-764F375188F4@holtmann.org>
 <a1bb325a569fe46660edcd11ba26c5cb@codeaurora.org>
 <471977a5037f06093945c5e71c78e538@codeaurora.org>
To:     Rocky Liao <rjliao@codeaurora.org>
X-Mailer: Apple Mail (2.3608.40.2.2.4)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rocky,

>>>> This patch add support for QCA6390.
>>> 
>>> can we please be a bit more descriptive on what support we are adding.
>>> 
>>>> 
>>>> Signed-off-by: Rocky Liao <rjliao@codeaurora.org>
>>>> ---
>>>> drivers/bluetooth/btqca.c   | 32 +++++++++++++++++++++--------
>>>> drivers/bluetooth/btqca.h   |  1 +
>>>> drivers/bluetooth/hci_qca.c | 40 ++++++++++++++++++++++++++++++++++---
>>>> 3 files changed, 62 insertions(+), 11 deletions(-)
>>>> 
>>>> diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
>>>> index ec69e5dd7bd3..75990223e5e3 100644
>>>> --- a/drivers/bluetooth/btqca.c
>>>> +++ b/drivers/bluetooth/btqca.c
>>>> @@ -13,6 +13,8 @@
>>>> #include "btqca.h"
>>>> 
>>>> #define VERSION "0.1"
>>> 
>>> Lets put an extra empty line here.
>> OK
>> 
>>> 
>>>> +#define QCA_IS_3991_6390(soc_type)    \
>>>> +    ((soc_type == QCA_WCN3991) || (soc_type == QCA_QCA6390))
>>> 
>>> Actually (a == b || c == d) is enough.
>>> 
>>> I rather do ((a) == b || (c) == d) to ensure the parameter is properly
>>> protected. It is not needed in this case since the usage is simple.
>> OK
>> 
>>> 
>>>> 
>>>> int qca_read_soc_version(struct hci_dev *hdev, u32 *soc_version,
>>>>              enum qca_btsoc_type soc_type)
>>>> @@ -32,7 +34,7 @@ int qca_read_soc_version(struct hci_dev *hdev, u32 *soc_version,
>>>>      * VSE event. WCN3991 sends version command response as a payload to
>>>>      * command complete event.
>>>>      */
>>>> -    if (soc_type == QCA_WCN3991) {
>>>> +    if (QCA_IS_3991_6390(soc_type)) {
>>>>         event_type = 0;
>>>>         rlen += 1;
>>>>         rtype = EDL_PATCH_VER_REQ_CMD;
>>>> @@ -69,7 +71,7 @@ int qca_read_soc_version(struct hci_dev *hdev, u32 *soc_version,
>>>>         goto out;
>>>>     }
>>>> 
>>>> -    if (soc_type == QCA_WCN3991)
>>>> +    if ((QCA_IS_3991_6390(soc_type)))
>>>>         memmove(&edl->data, &edl->data[1], sizeof(*ver));
>>> 
>>> Maybe these should just be turned into a switch statement and not
>>> using some macro.
>> Prefer to use macro or a simple function call, there are many places
>> called this and use switch will make code complex
>> 
>>>> 
>>>>     ver = (struct qca_btsoc_version *)(edl->data);
>>>> @@ -139,7 +141,7 @@ int qca_send_pre_shutdown_cmd(struct hci_dev *hdev)
>>>> EXPORT_SYMBOL_GPL(qca_send_pre_shutdown_cmd);
>>>> 
>>>> static void qca_tlv_check_data(struct qca_fw_config *config,
>>>> -                const struct firmware *fw)
>>>> +         const struct firmware *fw, enum qca_btsoc_type soc_type)
>>>> {
>>>>     const u8 *data;
>>>>     u32 type_len;
>>>> @@ -148,6 +150,7 @@ static void qca_tlv_check_data(struct qca_fw_config *config,
>>>>     struct tlv_type_hdr *tlv;
>>>>     struct tlv_type_patch *tlv_patch;
>>>>     struct tlv_type_nvm *tlv_nvm;
>>>> +    uint8_t nvm_baud_rate = config->user_baud_rate;
>>>> 
>>>>     tlv = (struct tlv_type_hdr *)fw->data;
>>>> 
>>>> @@ -213,10 +216,14 @@ static void qca_tlv_check_data(struct qca_fw_config *config,
>>>>                  * enabling software inband sleep
>>>>                  * onto controller side.
>>>>                  */
>>>> -                tlv_nvm->data[0] |= 0x80;
>>>> +                if (!QCA_IS_3991_6390(soc_type))
>>>> +                    tlv_nvm->data[0] |= 0x80;
>>>> 
>>>>                 /* UART Baud Rate */
>>>> -                tlv_nvm->data[2] = config->user_baud_rate;
>>>> +                if ((QCA_IS_3991_6390(soc_type)))
>>>> +                    tlv_nvm->data[1] = nvm_baud_rate;
>>>> +                else
>>>> +                    tlv_nvm->data[2] = nvm_baud_rate;
>>> 
>>> These two changes are not related to the QCA6390 support. Leave them
>>> out and if changes are needed to fix other hardware, then send them as
>>> separate patch.
>> OK
>> 
>>>> 
>>>>                 break;
>>>> 
>>>> @@ -264,7 +271,7 @@ static int qca_tlv_send_segment(struct hci_dev *hdev, int seg_size,
>>>>      * VSE event. WCN3991 sends version command response as a payload to
>>>>      * command complete event.
>>>>      */
>>>> -    if (soc_type == QCA_WCN3991) {
>>>> +    if ((QCA_IS_3991_6390(soc_type))) {
>>>>         event_type = 0;
>>>>         rlen = sizeof(*edl);
>>>>         rtype = EDL_PATCH_TLV_REQ_CMD;
>>>> @@ -297,7 +304,7 @@ static int qca_tlv_send_segment(struct hci_dev *hdev, int seg_size,
>>>>         err = -EIO;
>>>>     }
>>>> 
>>>> -    if (soc_type == QCA_WCN3991)
>>>> +    if ((QCA_IS_3991_6390(soc_type)))
>>>>         goto out;
>>>> 
>>>>     tlv_resp = (struct tlv_seg_resp *)(edl->data);
>>>> @@ -354,7 +361,7 @@ static int qca_download_firmware(struct hci_dev *hdev,
>>>>         return ret;
>>>>     }
>>>> 
>>>> -    qca_tlv_check_data(config, fw);
>>>> +    qca_tlv_check_data(config, fw, soc_type);
>>>> 
>>>>     segment = fw->data;
>>>>     remain = fw->size;
>>>> @@ -438,6 +445,12 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
>>>>                 (soc_ver & 0x0000000f);
>>>>         snprintf(config.fwname, sizeof(config.fwname),
>>>>              "qca/crbtfw%02x.tlv", rom_ver);
>>>> +    } else if (soc_type == QCA_QCA6390) {
>>>> +        rom_ver = ((soc_ver & 0x00000f00) >> 0x04) |
>>>> +                        (soc_ver & 0x0000000f);
>>>> +        snprintf(config.fwname, sizeof(config.fwname),
>>>> +             "qca/htbtfw%02x.tlv", rom_ver);
>>>> +
>>>>     } else {
>>>>         snprintf(config.fwname, sizeof(config.fwname),
>>>>              "qca/rampatch_%08x.bin", soc_ver);
>>>> @@ -460,6 +473,9 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
>>>>     else if (qca_is_wcn399x(soc_type))
>>>>         snprintf(config.fwname, sizeof(config.fwname),
>>>>              "qca/crnv%02x.bin", rom_ver);
>>>> +    else if (soc_type == QCA_QCA6390)
>>>> +        snprintf(config.fwname, sizeof(config.fwname),
>>>> +             "qca/htnv%02x.bin", rom_ver);
>>>>     else
>>>>         snprintf(config.fwname, sizeof(config.fwname),
>>>>              "qca/nvm_%08x.bin", soc_ver);
>>>> diff --git a/drivers/bluetooth/btqca.h b/drivers/bluetooth/btqca.h
>>>> index f5795b1a3779..2f06ed7e1c50 100644
>>>> --- a/drivers/bluetooth/btqca.h
>>>> +++ b/drivers/bluetooth/btqca.h
>>>> @@ -127,6 +127,7 @@ enum qca_btsoc_type {
>>>>     QCA_WCN3990,
>>>>     QCA_WCN3991,
>>>>     QCA_WCN3998,
>>>> +    QCA_QCA6390,
>>>> };
>>>> 
>>>> #if IS_ENABLED(CONFIG_BT_QCA)
>>>> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
>>>> index f10bdf8e1fc5..472f468145e8 100644
>>>> --- a/drivers/bluetooth/hci_qca.c
>>>> +++ b/drivers/bluetooth/hci_qca.c
>>>> @@ -25,6 +25,7 @@
>>>> #include <linux/mod_devicetable.h>
>>>> #include <linux/module.h>
>>>> #include <linux/of_device.h>
>>>> +#include <linux/acpi.h>
>>>> #include <linux/platform_device.h>
>>>> #include <linux/regulator/consumer.h>
>>>> #include <linux/serdev.h>
>>>> @@ -1355,6 +1356,16 @@ static const struct hci_uart_proto qca_proto = {
>>>>     .dequeue    = qca_dequeue,
>>>> };
>>>> 
>>>> +static const struct qca_vreg_data qca_soc_data_qca6174 = {
>>>> +    .soc_type = QCA_ROME,
>>>> +    .num_vregs = 0,
>>>> +};
>>>> +
>>>> +static const struct qca_vreg_data qca_soc_data_qca6390 = {
>>>> +    .soc_type = QCA_QCA6390,
>>>> +    .num_vregs = 0,
>>>> +};
>>>> +
>>>> static const struct qca_vreg_data qca_soc_data_wcn3990 = {
>>>>     .soc_type = QCA_WCN3990,
>>>>     .vregs = (struct qca_vreg []) {
>>>> @@ -1501,7 +1512,7 @@ static int qca_serdev_probe(struct serdev_device *serdev)
>>>>         return -ENOMEM;
>>>> 
>>>>     qcadev->serdev_hu.serdev = serdev;
>>>> -    data = of_device_get_match_data(&serdev->dev);
>>>> +    data = device_get_match_data(&serdev->dev);
>>> 
>>> I would address this in a separate patch since it seems you are
>>> actually fixing QCA6174 support as well. Or is this because the new
>>> platform is ACPI based. I can’t tell since you are missing a proper
>>> commit message.
>> OK
>>>>     serdev_device_set_drvdata(serdev, qcadev);
>>>>     device_property_read_string(&serdev->dev, "firmware-name",
>>>>                      &qcadev->firmware_name);
>>>> @@ -1534,7 +1545,10 @@ static int qca_serdev_probe(struct serdev_device *serdev)
>>>>             goto out;
>>>>         }
>>>>     } else {
>>>> -        qcadev->btsoc_type = QCA_ROME;
>>>> +        if (data)
>>>> +            qcadev->btsoc_type = data->soc_type;
>>>> +        else
>>>> +            qcadev->btsoc_type = QCA_ROME;
>>>>         qcadev->bt_en = devm_gpiod_get(&serdev->dev, "enable",
>>>>                            GPIOD_OUT_LOW);
>>>>         if (IS_ERR(qcadev->bt_en)) {
>>>> @@ -1670,21 +1684,41 @@ static int __maybe_unused qca_resume(struct device *dev)
>>>> 
>>>> static SIMPLE_DEV_PM_OPS(qca_pm_ops, qca_suspend, qca_resume);
>>>> 
>>>> +#ifdef CONFIG_OF
>>>> static const struct of_device_id qca_bluetooth_of_match[] = {
>>>> -    { .compatible = "qcom,qca6174-bt" },
>>>> +    { .compatible = "qcom,qca6174-bt"  .data = &qca_soc_data_qca6174},
>>> 
>>> So this should be clearly a separate patch as mentioned above.
>> OK
>>>> +    { .compatible = "qcom,qca6390-bt"  .data = &qca_soc_data_qca6390},
>>>>     { .compatible = "qcom,wcn3990-bt", .data = &qca_soc_data_wcn3990},
>>>>     { .compatible = "qcom,wcn3991-bt", .data = &qca_soc_data_wcn3991},
>>>>     { .compatible = "qcom,wcn3998-bt", .data = &qca_soc_data_wcn3998},
>>>>     { /* sentinel */ }
>>>> };
>>>> MODULE_DEVICE_TABLE(of, qca_bluetooth_of_match);
>>>> +#endif
>>>> +
>>>> +#ifdef CONFIG_ACPI
>>>> +static const struct acpi_device_id qca_bluetooth_acpi_match[] = {
>>>> +    { "QCOM6390", (kernel_ulong_t)&qca_soc_data_qca6390 },
>>>> +    { "DLA16390", (kernel_ulong_t)&qca_soc_data_qca6390 },
>>>> +    { "DLB16390", (kernel_ulong_t)&qca_soc_data_qca6390 },
>>>> +    { "DLB26390", (kernel_ulong_t)&qca_soc_data_qca6390 },
>>>> +    { },
>>>> +};
>>>> +MODULE_DEVICE_TABLE(acpi, qca_bluetooth_acpi_match);
>>>> +#endif
>>>> +
>>>> 
>>>> static struct serdev_device_driver qca_serdev_driver = {
>>>>     .probe = qca_serdev_probe,
>>>>     .remove = qca_serdev_remove,
>>>>     .driver = {
>>>>         .name = "hci_uart_qca",
>>>> +        #ifdef CONFIG_OF
>>>>         .of_match_table = qca_bluetooth_of_match,
>>>> +        #endif
>>>> +        #ifdef CONFIG_ACPI
>>>> +        .acpi_match_table = ACPI_PTR(qca_bluetooth_acpi_match),
>>>> +        #endif
>>> 
>>> These ifdefs are not needed. The ACPI_PTR does this automatically and
>>> there is another macro for OF as well that you can use.
>> OK
>>>>         .pm = &qca_pm_ops,
>>>>     },
>>>> };
>>> 
>>> Where is the patch addressing Kconfig dependency? If you support ACPI
>>> and DT platforms now, you need that.
>> OK
> I am a bit confusing what kind of Kconfig change is required,the driver shoud
> be able to work no matter it's ACPI or DT platform. We should have no
> dependency on ACPI or DT, right?

can this driver work without ACPI or DT? The other drivers have some dependency on ACPI or DT.

Regards

Marcel

